import 'package:stonfi/contracts/contract.dart';
import 'package:stonfi/contracts/dex/v2/pool/pool_v2.dart';
import 'package:stonfi/contracts/dex/v2/vault/vault_v2.dart';
import 'package:stonfi/contracts/pTON/pton.dart';
import 'package:stonfi/utils/create_jetton_transfer_message.dart';
import 'package:tonutils/tonutils.dart';

import '../../constants.dart';

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
  final GasPair singleSideProvideLpJetton;
  final GasPair singleSideProvideLpTon;

  RouterGasConstants({
    required this.swapJettonToJetton,
    required this.swapJettonToTon,
    required this.swapTonToJetton,
    required this.provideLpJetton,
    required this.provideLpTon,
    required this.singleSideProvideLpJetton,
    required this.singleSideProvideLpTon,
  });
}

class BaseRouterV2 extends StonfiContract {
  static DexVersion version = DexVersion.v2;
  static RouterGasConstants gasConstants = RouterGasConstants(
      swapJettonToJetton: GasPair(
        gasAmount: Nano.fromString("0.3"),
        forwardGasAmount: Nano.fromString("0.24"),
      ),
      swapJettonToTon: GasPair(
        gasAmount: Nano.fromString("0.3"),
        forwardGasAmount: Nano.fromString("0.24"),
      ),
      swapTonToJetton: GasPair(
        forwardGasAmount: Nano.fromString("0.3"),
      ),
      provideLpJetton: GasPair(
        gasAmount: Nano.fromString("0.3"),
        forwardGasAmount: Nano.fromString("0.235"),
      ),
      provideLpTon: GasPair(
        forwardGasAmount: Nano.fromString("0.3"),
      ),
      singleSideProvideLpJetton: GasPair(
        gasAmount: Nano.fromString("1"),
        forwardGasAmount: Nano.fromString("0.8"),
      ),
      singleSideProvideLpTon:
          GasPair(forwardGasAmount: Nano.fromString("0.8")));

  BaseRouterV2({required InternalAddress address, RouterGasConstants? gasConstants}) {
    this.address = address;

    BaseRouterV2.gasConstants = gasConstants ?? BaseRouterV2.gasConstants;
  }

  Cell createSwapBody({
    required InternalAddress askJettonWalletAddress,
    required InternalAddress receiverAddress,
    required BigInt minAskAmount,
    required InternalAddress refundAddress,
    InternalAddress? excessesAddress,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
    Cell? refundPayload,
    BigInt? refundForwardGasAmount,
    InternalAddress? referralAddress,
    BigInt? referralValue,
  }) {
    if (referralValue != null &&
        (referralValue < BigInt.zero || referralValue > BigInt.from(100))) {
      throw Exception("'referralValue' should be in range [0, 100] BPS");
    }

    return beginCell()
        .storeUint(DexOpCodes.SWAP.op, 32)
        .storeAddress(askJettonWalletAddress)
        .storeAddress(refundAddress)
        .storeAddress(excessesAddress ?? refundAddress)
        .storeRef(beginCell()
            .storeCoins(minAskAmount)
            .storeAddress(receiverAddress)
            .storeCoins(customPayloadForwardGasAmount ?? BigInt.zero)
            .storeMaybeRef(customPayload)
            .storeCoins(refundForwardGasAmount ?? BigInt.zero)
            .storeMaybeRef(refundPayload)
            .storeUint(referralValue ?? BigInt.from(10), 16)
            .storeAddress(referralAddress)
            .endCell())
        .endCell();
  }

  Cell createCrossSwapBody({
    required InternalAddress askJettonWalletAddress,
    required InternalAddress receiverAddress,
    required BigInt minAskAmount,
    required InternalAddress refundAddress,
    InternalAddress? excessesAddress,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
    Cell? refundPayload,
    BigInt? refundForwardGasAmount,
    InternalAddress? referralAddress,
    BigInt? referralValue,
  }) {
    if (referralValue != null &&
        (referralValue < BigInt.zero || referralValue > BigInt.from(100))) {
      throw Exception("'referralValue' should be in range [0, 100] BPS");
    }

    return beginCell()
        .storeUint(DexOpCodes.CROSS_SWAP.op, 32)
        .storeAddress(askJettonWalletAddress)
        .storeAddress(refundAddress)
        .storeAddress(excessesAddress ?? refundAddress)
        .storeRef(beginCell()
            .storeCoins(minAskAmount)
            .storeAddress(receiverAddress)
            .storeCoins(customPayloadForwardGasAmount ?? BigInt.zero)
            .storeMaybeRef(customPayload)
            .storeCoins(refundForwardGasAmount ?? BigInt.zero)
            .storeMaybeRef(refundPayload)
            .storeUint(referralValue ?? BigInt.from(10), 16)
            .storeAddress(referralAddress)
            .endCell())
        .endCell();
  }

  Future<SenderArguments> getSwapJettonToJettonTxParams({
    required InternalAddress userWalletAddress,
    required InternalAddress offerJettonAddress,
    required InternalAddress askJettonAddress,
    required BigInt offerAmount,
    required BigInt minAskAmount,
    InternalAddress? refundAddress,
    InternalAddress? excessesAddress,
    InternalAddress? referralAddress,
    BigInt? referralValue,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
    Cell? refundPayload,
    BigInt? refundForwardGasAmount,
    BigInt? gasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    final contractAddress = this.address;

    final offerJettonWalletAddress = await stonfiProvider!
        .open(JettonMaster(offerJettonAddress, provider))
        .getWalletAddress(userWalletAddress);
    final askJettonWalletAddress = await stonfiProvider!
        .open(JettonMaster(askJettonAddress, provider))
        .getWalletAddress(contractAddress);

    final forwardTonAmount =
        forwardGasAmount ?? gasConstants.swapJettonToJetton.forwardGasAmount;

    final forwardPayload = createSwapBody(
      askJettonWalletAddress: askJettonWalletAddress,
      receiverAddress: userWalletAddress,
      minAskAmount: minAskAmount,
      refundAddress: refundAddress ?? userWalletAddress,
      excessesAddress: excessesAddress,
      referralAddress: referralAddress,
      referralValue: referralValue,
      customPayload: customPayload,
      customPayloadForwardGasAmount: customPayloadForwardGasAmount,
      refundPayload: refundPayload,
      refundForwardGasAmount: refundForwardGasAmount,
    );

    final body = createJettonTransferMessage(
      queryId: queryId ?? BigInt.zero,
      amount: offerAmount,
      destination: contractAddress,
      responseDestination: userWalletAddress,
      forwardPayload: forwardPayload,
      forwardTonAmount: forwardTonAmount,
    );

    final value = gasAmount ?? gasConstants.swapJettonToJetton.gasAmount!;

    return SenderArguments(
        value: value, to: offerJettonWalletAddress, body: body);
  }

  Future<SenderArguments> getSwapJettonToTonTxParams({
    required InternalAddress userWalletAddress,
    required InternalAddress offerJettonAddress,
    required Pton proxyTon,
    required BigInt offerAmount,
    required BigInt minAskAmount,
    InternalAddress? refundAddress,
    InternalAddress? excessesAddress,
    InternalAddress? referralAddress,
    BigInt? referralValue,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
    Cell? refundPayload,
    BigInt? refundForwardGasAmount,
    BigInt? gasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    return await getSwapJettonToJettonTxParams(
      askJettonAddress: proxyTon.address,
      gasAmount: gasAmount ?? gasConstants.swapJettonToTon.gasAmount,
      forwardGasAmount:
          forwardGasAmount ?? gasConstants.swapJettonToTon.forwardGasAmount,
      queryId: queryId,
      userWalletAddress: userWalletAddress,
      offerAmount: offerAmount,
      minAskAmount: minAskAmount,
      offerJettonAddress: offerJettonAddress,
      referralAddress: referralAddress,
      refundAddress: refundAddress,
      customPayload: customPayload,
      customPayloadForwardGasAmount: customPayloadForwardGasAmount,
      excessesAddress: excessesAddress,
      referralValue: referralValue,
      refundForwardGasAmount: refundForwardGasAmount,
      refundPayload: refundPayload,
    );
  }

  Future<SenderArguments> getSwapTonToJettonTxParams({
    required InternalAddress userWalletAddress,
    required Pton proxyTon,
    required InternalAddress askJettonAddress,
    required BigInt offerAmount,
    required BigInt minAskAmount,
    InternalAddress? refundAddress,
    InternalAddress? excessesAddress,
    InternalAddress? referralAddress,
    BigInt? referralValue,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
    Cell? refundPayload,
    BigInt? refundForwardGasAmount,
    BigInt? gasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    final contractAddress = this.address;

    final askJettonWalletAddress = await stonfiProvider!
        .open(JettonMaster(askJettonAddress))
        .getWalletAddress(contractAddress);

    final forwardPayload = createSwapBody(
      askJettonWalletAddress: askJettonWalletAddress,
      receiverAddress: userWalletAddress,
      minAskAmount: minAskAmount,
      refundAddress: refundAddress ?? userWalletAddress,
      excessesAddress: excessesAddress,
      referralAddress: referralAddress,
      referralValue: referralValue,
      customPayload: customPayload,
      customPayloadForwardGasAmount: customPayloadForwardGasAmount,
      refundPayload: refundPayload,
      refundForwardGasAmount: refundForwardGasAmount,
    );

    final forwardTonAmount =
        forwardGasAmount ?? gasConstants.swapTonToJetton.forwardGasAmount;

    return await proxyTon.getTonTransferTxParams(
      queryId: queryId ?? BigInt.zero,
      tonAmount: offerAmount,
      destinationAddress: contractAddress,
      refundAddress: userWalletAddress,
      forwardPayload: forwardPayload,
      forwardTonAmount: forwardTonAmount,
    );
  }

  Cell createProvideLiquidityBody({
    required InternalAddress routerWalletAddress,
    required BigInt minLpOut,
    required InternalAddress receiverAddress,
    required InternalAddress refundAddress,
    bool bothPositive = false,
    InternalAddress? excessesAddress,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
  }) {
    return beginCell()
        .storeUint(DexOpCodes.PROVIDE_LP.op, 32)
        .storeAddress(routerWalletAddress)
        .storeAddress(refundAddress)
        .storeAddress(excessesAddress ?? refundAddress)
        .storeRef(beginCell()
            .storeCoins(minLpOut)
            .storeAddress(receiverAddress)
            .storeUint(bothPositive ? BigInt.one : BigInt.zero, 1)
            .storeCoins(customPayloadForwardGasAmount ?? BigInt.zero)
            .storeMaybeRef(customPayload)
            .endCell())
        .endCell();
  }

  Cell createCrossProvideLiquidityBody({
    required InternalAddress routerWalletAddress,
    required BigInt minLpOut,
    required InternalAddress receiverAddress,
    required InternalAddress refundAddress,
    bool bothPositive = false,
    InternalAddress? excessesAddress,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
  }) {
    return beginCell()
        .storeUint(DexOpCodes.CROSS_PROVIDE_LP.op, 32)
        .storeAddress(routerWalletAddress)
        .storeAddress(refundAddress)
        .storeAddress(excessesAddress ?? refundAddress)
        .storeRef(beginCell()
            .storeCoins(minLpOut)
            .storeAddress(receiverAddress)
            .storeUint(bothPositive ? BigInt.one : BigInt.zero, 1)
            .storeCoins(customPayloadForwardGasAmount ?? BigInt.zero)
            .storeMaybeRef(customPayload)
            .endCell())
        .endCell();
  }

  Future<SenderArguments> implGetProvideLiquidityJettonTxParams({
    required InternalAddress userWalletAddress,
    required InternalAddress sendTokenAddress,
    required InternalAddress otherTokenAddress,
    required BigInt sendAmount,
    required BigInt minLpOut,
    required BigInt gasAmount,
    required BigInt forwardGasAmount,
    bool bothPositive = false,
    InternalAddress? refundAddress,
    InternalAddress? excessesAddress,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
    BigInt? queryId,
  }) async {
    final contractAddress = this.address;

    final jettonWalletAddress = await stonfiProvider!
        .open(JettonMaster(sendTokenAddress))
        .getWalletAddress(userWalletAddress);
    final routerWalletAddress = await stonfiProvider!
        .open(JettonMaster(otherTokenAddress))
        .getWalletAddress(this.address);

    final forwardPayload = createProvideLiquidityBody(
      routerWalletAddress: routerWalletAddress,
      receiverAddress: userWalletAddress,
      minLpOut: minLpOut,
      refundAddress: refundAddress ?? userWalletAddress,
      excessesAddress: excessesAddress,
      customPayload: customPayload,
      customPayloadForwardGasAmount: customPayloadForwardGasAmount,
      bothPositive: bothPositive,
    );

    final forwardTonAmount = forwardGasAmount;

    final body = createJettonTransferMessage(
      queryId: queryId ?? BigInt.zero,
      amount: sendAmount,
      destination: contractAddress,
      responseDestination: userWalletAddress,
      forwardTonAmount: forwardTonAmount,
      forwardPayload: forwardPayload,
    );

    final value = gasAmount;

    return SenderArguments(value: value, to: jettonWalletAddress, body: body);
  }

  Future<SenderArguments> getProvideLiquidityJettonTxParams({
    required InternalAddress userWalletAddress,
    required InternalAddress sendTokenAddress,
    required InternalAddress otherTokenAddress,
    required BigInt sendAmount,
    required BigInt minLpOut,
    InternalAddress? refundAddress,
    InternalAddress? excessesAddress,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
    BigInt? gasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    return implGetProvideLiquidityJettonTxParams(
      userWalletAddress: userWalletAddress,
      sendTokenAddress: sendTokenAddress,
      otherTokenAddress: otherTokenAddress,
      sendAmount: sendAmount,
      minLpOut: minLpOut,
      excessesAddress: excessesAddress,
      customPayload: customPayload,
      customPayloadForwardGasAmount: customPayloadForwardGasAmount,
      refundAddress: refundAddress,
      bothPositive: true,
      queryId: queryId,
      gasAmount: gasAmount ?? gasConstants.provideLpJetton.gasAmount!,
      forwardGasAmount:
          forwardGasAmount ?? gasConstants.provideLpJetton.forwardGasAmount,
    );
  }

  Future<SenderArguments> getSingleSideProvideLiquidityJettonTxParams({
    required InternalAddress userWalletAddress,
    required InternalAddress sendTokenAddress,
    required InternalAddress otherTokenAddress,
    required BigInt sendAmount,
    required BigInt minLpOut,
    InternalAddress? refundAddress,
    InternalAddress? excessesAddress,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
    BigInt? gasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    return implGetProvideLiquidityJettonTxParams(
      userWalletAddress: userWalletAddress,
      sendTokenAddress: sendTokenAddress,
      otherTokenAddress: otherTokenAddress,
      sendAmount: sendAmount,
      minLpOut: minLpOut,
      excessesAddress: excessesAddress,
      customPayload: customPayload,
      customPayloadForwardGasAmount: customPayloadForwardGasAmount,
      refundAddress: refundAddress,
      bothPositive: false,
      queryId: queryId,
      gasAmount: gasAmount ?? gasConstants.singleSideProvideLpJetton.gasAmount!,
      forwardGasAmount: forwardGasAmount ??
          gasConstants.singleSideProvideLpJetton.forwardGasAmount,
    );
  }

  Future<SenderArguments> implGetProvideLiquidityTonTxParams({
    required InternalAddress userWalletAddress,
    required Pton proxyTon,
    required InternalAddress otherTokenAddress,
    required BigInt sendAmount,
    required BigInt minLpOut,
    required BigInt forwardGasAmount,
    InternalAddress? refundAddress,
    InternalAddress? excessesAddress,
    bool bothPositive = false,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
    BigInt? queryId,
  }) async {
    final contractAddress = this.address;

    final routerWalletAddress = await stonfiProvider!
        .open(JettonMaster(otherTokenAddress))
        .getWalletAddress(contractAddress);

    final forwardPayload = createProvideLiquidityBody(
      refundAddress: refundAddress ?? userWalletAddress,
      receiverAddress: userWalletAddress,
      excessesAddress: excessesAddress,
      customPayload: customPayload,
      customPayloadForwardGasAmount: customPayloadForwardGasAmount,
      bothPositive: bothPositive,
      routerWalletAddress: routerWalletAddress,
      minLpOut: minLpOut,
    );

    final forwardTonAmount = forwardGasAmount;

    return await proxyTon.getTonTransferTxParams(
      queryId: queryId ?? BigInt.zero,
      tonAmount: sendAmount,
      destinationAddress: contractAddress,
      refundAddress: userWalletAddress,
      forwardPayload: forwardPayload,
      forwardTonAmount: forwardTonAmount,
    );
  }

  Future<SenderArguments> getProvideLiquidityTonTxParams({
    required InternalAddress userWalletAddress,
    required Pton proxyTon,
    required InternalAddress otherTokenAddress,
    required BigInt sendAmount,
    required BigInt minLpOut,
    InternalAddress? refundAddress,
    InternalAddress? excessesAddress,
    bool bothPositive = false,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    return implGetProvideLiquidityTonTxParams(
      bothPositive: true,
      refundAddress: refundAddress,
      customPayloadForwardGasAmount: customPayloadForwardGasAmount,
      customPayload: customPayload,
      excessesAddress: excessesAddress,
      userWalletAddress: userWalletAddress,
      proxyTon: proxyTon,
      otherTokenAddress: otherTokenAddress,
      sendAmount: sendAmount,
      minLpOut: minLpOut,
      queryId: queryId,
      forwardGasAmount:
          forwardGasAmount ?? gasConstants.provideLpTon.forwardGasAmount,
    );
  }

  Future<SenderArguments> getSingleSideProvideLiquidityTonTxParams({
    required InternalAddress userWalletAddress,
    required Pton proxyTon,
    required InternalAddress otherTokenAddress,
    required BigInt sendAmount,
    required BigInt minLpOut,
    InternalAddress? refundAddress,
    InternalAddress? excessesAddress,
    bool bothPositive = false,
    Cell? customPayload,
    BigInt? customPayloadForwardGasAmount,
    BigInt? forwardGasAmount,
    BigInt? queryId,
  }) async {
    return implGetProvideLiquidityTonTxParams(
      bothPositive: false,
      refundAddress: refundAddress,
      customPayloadForwardGasAmount: customPayloadForwardGasAmount,
      customPayload: customPayload,
      excessesAddress: excessesAddress,
      userWalletAddress: userWalletAddress,
      proxyTon: proxyTon,
      otherTokenAddress: otherTokenAddress,
      sendAmount: sendAmount,
      minLpOut: minLpOut,
      queryId: queryId,
      forwardGasAmount: forwardGasAmount ??
          gasConstants.singleSideProvideLpJetton.forwardGasAmount,
    );
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

  Future<PoolV2> getPool({
    required InternalAddress token0,
    required InternalAddress token1,
  }) async {
    return PoolV2(
        await getPoolAddressByJettonMinters(token0: token0, token1: token1));
  }

  Future<InternalAddress> getVaultAddress({
    required InternalAddress user,
    required InternalAddress tokenWallet,
  }) async {
    final result = await stonfiProvider!.get("get_vault_address", [
      TiSlice(beginCell().storeAddress(user).endCell()),
      TiSlice(beginCell().storeAddress(tokenWallet).endCell()),
    ]);

    return result.stack.readAddress();
  }

  Future<VaultV2> getVault({
    required InternalAddress user,
    required InternalAddress tokenWallet,
  }) async {
    return VaultV2(
        await getVaultAddress(user: user, tokenWallet: tokenWallet));
  }

  Future<({int major, int minor, String development})>
      getRouterVersion() async {
    final result = await stonfiProvider!.get("get_router_version", []);

    return (
      major: result.stack.readInt(),
      minor: result.stack.readInt(),
      development: String.fromCharCodes((result.stack.readString().toString().replaceAll('[', '').replaceAll(']', '')).split(',').map((e) => int.parse(e.trim()))),
    );
  }

  Future<({
        int routerId,
        DexType dexType,
        bool isLocked,
        InternalAddress adminAddress,
        Cell tempUpgrade,
        Cell poolCode,
        Cell jettonLpWalletCode,
        Cell lpAccountCode,
        Cell vaultCode,
      })> getRouterData() async {
    final result = await stonfiProvider!.get("get_router_data", []);
    return (
      routerId: result.stack.readInt(),
      dexType: DexType.values
          .firstWhere((e) => (String.fromCharCodes((result.stack.readString().toString().replaceAll('[', '').replaceAll(']', '')).split(',').map((e) => int.parse(e.trim())))) == e.value),
      isLocked: result.stack.readBool(),
      adminAddress: result.stack.readAddress(),
      tempUpgrade: result.stack.readCell(),
      poolCode: result.stack.readCell(),
      jettonLpWalletCode: result.stack.readCell(),
      lpAccountCode: result.stack.readCell(),
      vaultCode: result.stack.readCell(),
    );
  }
}
