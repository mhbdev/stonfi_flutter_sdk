import 'package:stonfi/contracts/contract.dart';
import 'package:stonfi/contracts/contract_provider.dart';
import 'package:stonfi/contracts/dex/v1/pool_v1.dart';
import 'package:stonfi/contracts/pTON/v1/pton_v1.dart';
import 'package:stonfi/utils/create_jetton_transfer_message.dart';
import 'package:tonutils/tonutils.dart';

import '../constants.dart';

class GasPair {
  final BigInt? gasAmount;
  final BigInt forwardGasAmount;

  GasPair({this.gasAmount, required this.forwardGasAmount});
}

class RouterGasConstants {
  final GasPair swapJettonToJetton;
  final GasPair swapJettonToTon;
  final GasPair swapTonToJetton;
  final GasPair provideLpJetton;
  final GasPair provideLpTon;

  RouterGasConstants(
      {required this.swapJettonToJetton,
      required this.swapJettonToTon,
      required this.swapTonToJetton,
      required this.provideLpJetton,
      required this.provideLpTon});
}

class RouterV1 extends StonfiContract {
  static DexVersion version = DexVersion.v1;
  static RouterGasConstants gasConstants = RouterGasConstants(
    swapJettonToJetton: GasPair(
      gasAmount: Nano.fromString("0.22"),
      forwardGasAmount: Nano.fromString("0.175"),
    ),
    swapJettonToTon: GasPair(
      gasAmount: Nano.fromString("0.17"),
      forwardGasAmount: Nano.fromString("0.125"),
    ),
    swapTonToJetton: GasPair(
      forwardGasAmount: Nano.fromString("0.185"),
    ),
    provideLpJetton: GasPair(
      gasAmount: Nano.fromString("0.3"),
      forwardGasAmount: Nano.fromString("0.24"),
    ),
    provideLpTon: GasPair(
      forwardGasAmount: Nano.fromString("0.26"),
    ),
  );

  RouterV1({InternalAddress? address, RouterGasConstants? gasConstants}) {
    this.address = address ??
        InternalAddress.parse(
            "EQB3ncyBUTjZUA5EnFKR5_EnOMI9V1tTEAAPaiU71gc4TiUt");

    RouterV1.gasConstants = gasConstants ?? RouterV1.gasConstants;
  }

  Cell createSwapBody({
    required InternalAddress userWalletAddress,
    required BigInt minAskAmount,
    required InternalAddress askJettonWalletAddress,
    InternalAddress? referralAddress,
  }) {
    final builder = Builder();
    builder
        .storeUint(DexOpCodes.SWAP.op, 32)
        .storeAddress(askJettonWalletAddress)
        .storeCoins(minAskAmount)
        .storeAddress(userWalletAddress);

    if (referralAddress != null) {
      builder.storeUint(BigInt.from(1), 1).storeAddress(referralAddress);
    } else {
      builder.storeUint(BigInt.zero, 1);
    }

    return builder.endCell();
  }

  Future<SenderArguments> getSwapJettonToJettonTxParams({
    required InternalAddress userWalletAddress,
    required InternalAddress offerJettonAddress,
    required InternalAddress askJettonAddress,
    required BigInt offerAmount,
    required BigInt minAskAmount,
    InternalAddress? referralAddress,
    BigInt? gasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    final offerJettonWalletAddress = await stonfiProvider!
        .open(JettonMaster(offerJettonAddress, provider))
        .getWalletAddress(userWalletAddress);
    final askJettonWalletAddress = await stonfiProvider!
        .open(JettonMaster(askJettonAddress, provider))
        .getWalletAddress(this.address);

    final forwardPayload = createSwapBody(
      userWalletAddress: userWalletAddress,
      minAskAmount: minAskAmount,
      askJettonWalletAddress: askJettonWalletAddress,
      referralAddress: referralAddress,
    );

    final forwardTonAmount =
        forwardGasAmount ?? gasConstants.swapJettonToJetton.forwardGasAmount;

    final body = createJettonTransferMessage(
      customPayload: null,
      queryId: queryId ?? BigInt.zero,
      amount: offerAmount,
      destination: this.address,
      responseDestination: userWalletAddress,
      forwardTonAmount: forwardTonAmount,
      forwardPayload: forwardPayload,
    );

    final value = gasAmount ?? gasConstants.swapJettonToJetton.gasAmount!;

    return SenderArguments(
        value: value, to: offerJettonWalletAddress, body: body);
  }

  Future<void> sendSwapJettonToJetton(
    Sender via, {
    required InternalAddress userWalletAddress,
    required InternalAddress offerJettonAddress,
    required InternalAddress askJettonAddress,
    required BigInt offerAmount,
    required BigInt minAskAmount,
    InternalAddress? referralAddress,
    BigInt? gasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    return via.send(await getSwapJettonToJettonTxParams(
      askJettonAddress: askJettonAddress,
      minAskAmount: minAskAmount,
      offerAmount: offerAmount,
      offerJettonAddress: offerJettonAddress,
      userWalletAddress: userWalletAddress,
      gasAmount: gasAmount,
      queryId: queryId,
      forwardGasAmount: forwardGasAmount,
      referralAddress: referralAddress,
    ));
  }

  Future<SenderArguments> getSwapJettonToTonTxParams(
      {required InternalAddress userWalletAddress,
      required InternalAddress offerJettonAddress,
      required PtonV1 proxyTon,
      required BigInt offerAmount,
      required BigInt minAskAmount,
      InternalAddress? referralAddress,
      BigInt? gasAmount,
      BigInt? forwardGasAmount,
      BigInt? queryId}) async {
    return await getSwapJettonToJettonTxParams(
        askJettonAddress: proxyTon.address,
        gasAmount: gasAmount ?? gasConstants.swapJettonToTon.gasAmount,
        forwardGasAmount:
            forwardGasAmount ?? gasConstants.swapJettonToTon.forwardGasAmount,
        userWalletAddress: userWalletAddress,
        offerJettonAddress: offerJettonAddress,
        offerAmount: offerAmount,
        minAskAmount: minAskAmount,
        queryId: queryId,
        referralAddress: referralAddress);
  }

  Future<void> sendSwapJettonToTon(ContractProvider provider, Sender via,
      {required InternalAddress userWalletAddress,
      required InternalAddress offerJettonAddress,
      required PtonV1 proxyTon,
      required BigInt offerAmount,
      required BigInt minAskAmount,
      InternalAddress? referralAddress,
      BigInt? gasAmount,
      BigInt? forwardGasAmount,
      BigInt? queryId}) async {
    return via.send(await getSwapJettonToTonTxParams(
      proxyTon: proxyTon,
      minAskAmount: minAskAmount,
      offerAmount: offerAmount,
      offerJettonAddress: offerJettonAddress,
      userWalletAddress: userWalletAddress,
      gasAmount: gasAmount,
      queryId: queryId,
      forwardGasAmount: forwardGasAmount,
      referralAddress: referralAddress,
    ));
  }

  Future<SenderArguments> getSwapTonToJettonTxParams({
    required InternalAddress userWalletAddress,
    required PtonV1 proxyTon,
    required InternalAddress askJettonAddress,
    required BigInt offerAmount,
    required BigInt minAskAmount,
    InternalAddress? referralAddress,
    BigInt? gasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    final askJettonWalletAddress = await stonfiProvider!
        .open(JettonMaster(askJettonAddress))
        .getWalletAddress(this.address);

    final forwardPayload = createSwapBody(
      userWalletAddress: userWalletAddress,
      minAskAmount: minAskAmount,
      askJettonWalletAddress: askJettonWalletAddress,
      referralAddress: referralAddress,
    );

    final forwardTonAmount =
        forwardGasAmount ?? gasConstants.swapTonToJetton.forwardGasAmount;

    return await proxyTon.getTonTransferTxParams(
      queryId: queryId ?? BigInt.zero,
      tonAmount: offerAmount,
      destinationAddress: this.address,
      refundAddress: userWalletAddress,
      forwardPayload: forwardPayload,
      forwardTonAmount: forwardTonAmount,
    );
  }

  Future<void> sendSwapTonToJetton(
    StonfiContractProvider provider,
    Sender via, {
    required InternalAddress userWalletAddress,
    required PtonV1 proxyTon,
    required InternalAddress askJettonAddress,
    required BigInt offerAmount,
    required BigInt minAskAmount,
    InternalAddress? referralAddress,
    BigInt? gasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    return via.send(await getSwapTonToJettonTxParams(
        minAskAmount: minAskAmount,
        offerAmount: offerAmount,
        userWalletAddress: userWalletAddress,
        askJettonAddress: askJettonAddress,
        proxyTon: proxyTon,
        referralAddress: referralAddress,
        queryId: queryId,
        forwardGasAmount: forwardGasAmount,
        gasAmount: gasAmount));
  }

  Cell createProvideLiquidityBody({
    required InternalAddress routerWalletAddress,
    required BigInt minLpOut,
  }) {
    return beginCell()
        .storeUint(DexOpCodes.PROVIDE_LP.op, 32)
        .storeAddress(routerWalletAddress)
        .storeCoins(minLpOut)
        .endCell();
  }

  Future<SenderArguments> getProvideLiquidityJettonTxParams({
    required InternalAddress userWalletAddress,
    required InternalAddress sendTokenAddress,
    required InternalAddress otherTokenAddress,
    required BigInt sendAmount,
    required BigInt minLpOut,
    BigInt? gasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    final jettonWalletAddress = await stonfiProvider!
        .open(JettonMaster(sendTokenAddress))
        .getWalletAddress(userWalletAddress);
    final routerWalletAddress = await stonfiProvider!
        .open(JettonMaster(otherTokenAddress))
        .getWalletAddress(this.address);

    final forwardPayload = createProvideLiquidityBody(
      routerWalletAddress: routerWalletAddress,
      minLpOut: minLpOut,
    );

    final forwardTonAmount =
        forwardGasAmount ?? gasConstants.provideLpJetton.forwardGasAmount;

    final body = createJettonTransferMessage(
      queryId: queryId ?? BigInt.zero,
      amount: sendAmount,
      destination: this.address,
      responseDestination: userWalletAddress,
      forwardTonAmount: forwardTonAmount,
      forwardPayload: forwardPayload,
    );

    final value = gasAmount ?? gasConstants.provideLpJetton.gasAmount!;

    return SenderArguments(value: value, to: jettonWalletAddress, body: body);
  }

  Future<void> sendProvideLiquidityJetton(
    ContractProvider provider,
    Sender via, {
    required InternalAddress userWalletAddress,
    required InternalAddress sendTokenAddress,
    required InternalAddress otherTokenAddress,
    required BigInt sendAmount,
    required BigInt minLpOut,
    BigInt? gasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    final txParams = await getProvideLiquidityJettonTxParams(
        userWalletAddress: userWalletAddress,
        minLpOut: minLpOut,
        otherTokenAddress: otherTokenAddress,
        sendAmount: sendAmount,
        sendTokenAddress: sendTokenAddress,
        gasAmount: gasAmount,
        forwardGasAmount: forwardGasAmount,
        queryId: queryId);
    return via.send(txParams);
  }

  Future<SenderArguments> getProvideLiquidityTonTxParams({
    required InternalAddress userWalletAddress,
    required PtonV1 proxyTon,
    required InternalAddress otherTokenAddress,
    required BigInt sendAmount,
    required BigInt minLpOut,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    final routerWalletAddress = await stonfiProvider!
        .open(JettonMaster(otherTokenAddress))
        .getWalletAddress(this.address);

    final forwardPayload = createProvideLiquidityBody(
      routerWalletAddress: routerWalletAddress,
      minLpOut: minLpOut,
    );

    final forwardTonAmount =
        forwardGasAmount ?? gasConstants.provideLpTon.forwardGasAmount;

    return await proxyTon.getTonTransferTxParams(
      queryId: queryId ?? BigInt.zero,
      tonAmount: sendAmount,
      destinationAddress: this.address,
      refundAddress: userWalletAddress,
      forwardPayload: forwardPayload,
      forwardTonAmount: forwardTonAmount,
    );
  }

  Future<void> sendProvideLiquidityTon(
    ContractProvider provider,
    Sender via, {
    required InternalAddress userWalletAddress,
    required PtonV1 proxyTon,
    required InternalAddress otherTokenAddress,
    required BigInt sendAmount,
    required BigInt minLpOut,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    final txParams = await getProvideLiquidityTonTxParams(
      sendAmount: sendAmount,
      otherTokenAddress: otherTokenAddress,
      minLpOut: minLpOut,
      userWalletAddress: userWalletAddress,
      proxyTon: proxyTon,
      queryId: queryId,
      forwardGasAmount: forwardGasAmount,
    );
    return via.send(txParams);
  }

  Future<InternalAddress> getPoolAddress({
    required InternalAddress token0,
    required InternalAddress token1,
  }) async {
    final result = await stonfiProvider!.get("get_pool_address", [
      TiSlice(beginCell().storeAddress(token0).endCell()),
      TiSlice(beginCell().storeAddress(token1).endCell()),
    ]);

    return result.stack.readAddress();
  }

  Future<InternalAddress> getPoolAddressByJettonMinters({
    required InternalAddress token0,
    required InternalAddress token1,
  }) async {
    final jetton0WalletAddress = await stonfiProvider!
        .open(JettonMaster(token0, provider))
        .getWalletAddress(this.address);
    final jetton1WalletAddress = await stonfiProvider!
        .open(JettonMaster(token1, provider))
        .getWalletAddress(this.address);

    return getPoolAddress(
        token0: jetton0WalletAddress, token1: jetton1WalletAddress);
  }

  Future<PoolV1> getPool({
    required InternalAddress token0,
    required InternalAddress token1,
  }) async {
    return PoolV1(await getPoolAddressByJettonMinters(token0: token0, token1: token1));
  }

  Future<
      ({
        bool isLocked,
        InternalAddress adminAddress,
        Cell tempUpgrade,
        Cell poolCode,
        Cell jettonLpWalletCode,
        Cell lpAccountCode,
      })> getRouterData() async {
    final result = await stonfiProvider!.get("get_router_data", []);
    return (
      isLocked: result.stack.readBool(), //isLocked
      adminAddress: result.stack.readAddress(), //adminAddress
      tempUpgrade: result.stack.readCell(), // tempUpgrade
      poolCode: result.stack.readCell(), //poolCode
      jettonLpWalletCode: result.stack.readCell(), //jettonLpWalletCode
      lpAccountCode: result.stack.readCell(), //lpAccountCode
    );
  }
}
