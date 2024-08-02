import 'package:flutter/foundation.dart';
import 'package:stonfi/contracts/dex/v2/lp_account_v2.dart';
import 'package:tonutils/dataformat.dart';
import 'package:tonutils/jetton.dart';

import '../../constants.dart';

typedef CommonPoolData = ({
  bool isLocked,
  InternalAddress routerAddress,
  BigInt totalSupplyLP,
  BigInt reserve0,
  BigInt reserve1,
  InternalAddress token0WalletAddress,
  InternalAddress token1WalletAddress,
  BigInt lpFee,
  BigInt protocolFee,
  InternalAddress? protocolFeeAddress,
  BigInt collectedToken0ProtocolFee,
  BigInt collectedToken1ProtocolFee,
});

class PoolGasConstant {
  final BigInt collectFees;
  final BigInt burn;

  PoolGasConstant({
    required this.collectFees,
    required this.burn,
  });
}

class BasePoolV2 extends JettonMaster {
  static DexVersion version = DexVersion.v2;
  static PoolGasConstant gasConstants = PoolGasConstant(
    collectFees: Nano.fromString("0.4"),
    burn: Nano.fromString("0.8"),
  );

  BasePoolV2(super.address, [super.provider, PoolGasConstant? gasConstants]) {
    BasePoolV2.gasConstants = gasConstants ?? BasePoolV2.gasConstants;
  }

  Cell createCollectFeesBody({
    BigInt? queryId,
  }) {
    return beginCell()
        .storeUint(DexOpCodes.COLLECT_FEES.op, 32)
        .storeUint(queryId ?? BigInt.zero, 64)
        .endCell();
  }

  SenderArguments getCollectFeeTxParams({
    BigInt? gasAmount,
    BigInt? queryId,
  }) {
    final to = this.address;
    final body = createCollectFeesBody(queryId: queryId);
    final value = gasAmount ?? gasConstants.collectFees;

    return SenderArguments(to: to, value: value, body: body);
  }

  Future<void> sendCollectFees(
    ContractProvider provider,
    Sender via, {
    BigInt? gasAmount,
    BigInt? queryId,
  }) async {
    final txParams =
        getCollectFeeTxParams(gasAmount: gasAmount, queryId: queryId);

    return via.send(txParams);
  }

  Cell createBurnBody({
    required BigInt amount,
    Cell? customPayload,
    BigInt? queryId,
  }) {
    return beginCell()
        .storeUint(DexOpCodes.BURN.op, 32)
        .storeUint(queryId ?? BigInt.zero, 64)
        .storeCoins(amount)
        .storeAddress(null)
        .storeMaybeRef(customPayload)
        .endCell();
  }

  Future<SenderArguments> getBurnTxParams({
    required InternalAddress userWalletAddress,
    required BigInt amount,
    Cell? customPayload,
    BigInt? gasAmount,
    BigInt? queryId,
  }) async {
    final to = await getWalletAddress(userWalletAddress);
    final body = createBurnBody(
      amount: amount,
      customPayload: customPayload,
      queryId: queryId,
    );
    final value = gasAmount ?? gasConstants.burn;

    return SenderArguments(to: to, value: value, body: body);
  }

  Future<void> sendBurn(
    Sender via, {
    required InternalAddress userWalletAddress,
    required BigInt amount,
    Cell? customPayload,
    BigInt? gasAmount,
    BigInt? queryId,
  }) async {
    final txParams = await getBurnTxParams(
        amount: amount,
        userWalletAddress: userWalletAddress,
        customPayload: customPayload,
        gasAmount: gasAmount,
        queryId: queryId);

    return via.send(txParams);
  }

  Future<DexType> getPoolType() async {
    final result = await provider!.get('get_pool_type', []);
    return DexType.values.firstWhere((e) => e == result.stack.readString());
  }

  Future<(BigInt, BigInt, BigInt)> getExpectedOutputs(ContractProvider provider,
      {required BigInt amount, required InternalAddress jettonWallet}) async {
    final result = await provider.get("get_expected_outputs", [
      TiInt(amount),
      TiSlice(beginCell().storeAddress(jettonWallet).endCell()),
    ]);
    return (
      result.stack.readBigInt(), // jettonToReceive
      result.stack.readBigInt(), // protocolFeePaid
      result.stack.readBigInt() // refFeePaid
    );
  }

  Future<InternalAddress> getLpAccountAddress(
      {required InternalAddress ownerAddress}) async {
    final result = await provider!.get("get_lp_account_address", [
      TiSlice(beginCell().storeAddress(ownerAddress).endCell()),
    ]);
    return result.stack.readAddress();
  }

  Future<LpAccountV2> getLpAccount(ContractProvider provider,
      {required InternalAddress ownerAddress}) async {
    final lpAccountAddress =
        await getLpAccountAddress(ownerAddress: ownerAddress);
    return LpAccountV2.create(lpAccountAddress);
  }

  Future<JettonWallet> getJettonWallet(ContractProvider provider,
      {required InternalAddress ownerAddress}) async {
    final jettonWalletAddress = await getWalletAddress(ownerAddress);
    return JettonWallet.create(jettonWalletAddress);
  }

  Future<CommonPoolData> getPoolData() async {
    return (await implGetPoolData(provider!)).commonPoolData;
  }

  Future<({CommonPoolData commonPoolData, TupleReader stack})> implGetPoolData(
      ContractProvider provider) async {
    final result = await provider.get("get_pool_data", []);
    return (
      commonPoolData: (
        isLocked: result.stack.readBool(),
        routerAddress: result.stack.readAddress(),
        totalSupplyLP: result.stack.readBigInt(),
        reserve0: result.stack.readBigInt(),
        reserve1: result.stack.readBigInt(),
        token0WalletAddress: result.stack.readAddress(),
        token1WalletAddress: result.stack.readAddress(),
        lpFee: result.stack.readBigInt(),
        protocolFee: result.stack.readBigInt(),
        protocolFeeAddress: result.stack.readAddressOrNull(),
        collectedToken0ProtocolFee: result.stack.readBigInt(),
        collectedToken1ProtocolFee: result.stack.readBigInt(),
      ),
      stack: result.stack,
    );
  }
}
