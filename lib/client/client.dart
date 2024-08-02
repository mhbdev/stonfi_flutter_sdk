import 'dart:convert';
import 'dart:typed_data';

import 'package:stonfi/api/client_index.dart';
import 'package:stonfi/contracts/contract_provider.dart';
import 'package:tonutils/client.dart';
import 'package:tonutils/tonutils.dart';

class TonClientParameters {
  /// API Endpoint
  final String endpoint;

  /// HTTP request timeout in milliseconds.
  final int? timeout;

  /// API Key
  final String? apiKey;

  TonClientParameters(this.endpoint, {this.timeout, this.apiKey});
}

class Client extends TonJsonRpc {
  late StonfiApi _client;

  Client([
    super.endpoint,
    super.apiKey,
    super.timeout = 30000,
  ]) {
    _client = StonfiApi.create(
      baseUrl: Uri.parse('https://api.ston.fi'),
    );
  }

  @override
  Future<({int gasUsed, TupleReader stack})> runMethod(
      InternalAddress address, String methodName,
      [List<TupleItem> stack = const <TupleItem>[]]) async {

    if (methodName == 'get_wallet_address' && stack[0] is TiSlice) {
      try {
        final jettonWalletAddress = await _client.v1JettonAddrStrAddressGet(
              addrStr: 'get_wallet_address',
              ownerAddress: (stack[0] as TiSlice).cell.beginParse().loadInternalAddress().toString(),
            );

        return (
          gasUsed: 0,
          stack: TupleReader([
            TiSlice(beginCell()
                .storeAddress(InternalAddress.parse(jettonWalletAddress.body?.address ?? ''))
                .endCell())
          ]),
        );
      } catch (e) {
        // ignored
      }
    }

    return super.runMethod(address, methodName, stack);
  }

  @override
  T open<T extends Contract>(T src) {
    return openContract<T>(
        src,
            ({required InternalAddress address, ContractInit? init}) =>
            _createProvider(
                this,
                address,
                init != null
                    ? ContractMaybeInit(
                  code: init.code,
                  data: init.data,
                )
                    : null));
  }

  @override
  StonfiContractProvider provider(InternalAddress address, ContractMaybeInit? init) {
    return _createProvider(this, address, init);
  }

  StonfiContractProvider _createProvider(
      TonJsonRpc client,
      InternalAddress address,
      ContractMaybeInit? init,
      ) {
    final provider = StonfiContractProvider(
      // getState
          () async {
        var state = await client.getContractState(address);
        var balance = state.balance;
        var last = state.lastTransaction != null
            ? ContractStateLast(
          lt: BigInt.parse(state.lastTransaction!.lt),
          hash: Uint8List.fromList(
              base64.decode(state.lastTransaction!.hash)),
        )
            : null;
        ContractStateType storage;
        switch (state.state) {
          case 'active':
            storage = CstActive(
              code: state.code,
              data: state.data,
            );

          case 'uninitialized':
            storage = CstUninit();

          case 'frozen':
            storage = CstFrozen(stateHash: Uint8List(0));

          case _:
            throw 'Unsupported state ${state.state}';
        }

        return ContractState(
          balance: balance,
          last: last,
          state: storage,
        );
      },
      // get
          (name, args) async {
        var method = await client.runMethod(address, name, args);
        return ContractGetMethodResult(
          stack: method.stack,
          gasUsed: BigInt.from(method.gasUsed),
        );
      },
      // external
          (message) async {
        // Resolve init
        ContractMaybeInit? neededInit;
        if (init != null &&
            (await client.isContractDeployed(address)) == false) {
          neededInit = init;
        }

        // Send
        final ext = external(
          to: SiaInternalAddress(address),
          init: neededInit,
          body: message,
        );
        var boc = beginCell().store(storeMessage(ext)).endCell().toBoc();
        await client.sendFile(boc);
      },
      // internal
          (
          via, {
        required StringBigInt value,
        StringCell? body,
        bool? bounce,
        SendMode? sendMode,
      }) async {
        // Resolve init
        ContractMaybeInit? neededInit;
        if (init != null &&
            (await client.isContractDeployed(address)) == false) {
          neededInit = init;
        }

        // Resolve bounce
        var lBounce = true;
        if (bounce != null) {
          lBounce = bounce;
        }

        // Resolve value
        BigInt lValue;
        switch (value) {
          case SbiString():
            lValue = Nano.fromString(value.value);

          case SbiBigInt():
            lValue = value.value;
        }

        // Resolve body
        Cell? lBody;
        switch (body) {
          case ScString():
            lBody = comment(body.value);

          case ScCell():
            lBody = body.value;

          case null:
            break;
        }

        // Send internal message
        await via.send(SenderArguments(
          to: address,
          value: lValue,
          bounce: lBounce,
          sendMode: sendMode,
          init: neededInit,
          body: lBody,
        ));
      },
    );
    provider.open = open;
    return provider;
  }
}
