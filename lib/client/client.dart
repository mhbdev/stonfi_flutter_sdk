import 'package:stonfi/api/client_index.dart';
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
  late Stonfi _client;

  Client([
    super.endpoint,
    super.apiKey,
    super.timeout = 30000,
  ]) {
    _client = Stonfi.create(
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
}
