import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/contracts/dex/v1/lp_account_v1.dart';
import 'package:tonutils/tonutils.dart';

class PoolGasConstant {
  final BigInt collectFees;
  final BigInt burn;

  PoolGasConstant({
    required this.collectFees,
    required this.burn,
  });
}

class PoolV1 extends JettonMaster {
  static DexVersion version = DexVersion.v1;
  static PoolGasConstant gasConstants = PoolGasConstant(
    collectFees: Nano.fromString("1.1"),
    burn: Nano.fromString("0.5"),
  );

  PoolV1(super.address, [super.provider, PoolGasConstant? gasConstants]) {
    PoolV1.gasConstants = gasConstants ?? PoolV1.gasConstants;
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

  Future<void> sendCollectFees(ContractProvider provider,
      Sender via, {
        BigInt? gasAmount,
        BigInt? queryId,
      }) async {
    final txParams =
    getCollectFeeTxParams(gasAmount: gasAmount, queryId: queryId);

    return via.send(txParams);
  }

  Cell createBurnBody({
    required InternalAddress responseAddress,
    required BigInt amount,
    BigInt? queryId,
  }) {
    return beginCell()
        .storeUint(DexOpCodes.BURN.op, 32)
        .storeUint(queryId ?? BigInt.zero, 64)
        .storeCoins(amount)
        .storeAddress(responseAddress)
        .endCell();
  }

  Future<SenderArguments> getBurnTxParams(ContractProvider provider, {
    required InternalAddress responseAddress,
    required BigInt amount,
    BigInt? gasAmount,
    BigInt? queryId,
  }) async {
    final to = await getWalletAddress(responseAddress);
    final body = createBurnBody(
      amount: amount,
      responseAddress: responseAddress,
      queryId: queryId,
    );
    final value = gasAmount ?? gasConstants.burn;

    return SenderArguments(to: to, value: value, body: body);
  }

  Future<void> sendBurn(ContractProvider provider,
      Sender via, {
        required InternalAddress responseAddress,
        required BigInt amount,
        BigInt? gasAmount,
        BigInt? queryId,
      }) async {
    final txParams = await getBurnTxParams(provider,
        amount: amount,
        responseAddress: responseAddress,
        gasAmount: gasAmount,
        queryId: queryId);

    return via.send(txParams);
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

  Future<BigInt> getExpectedTokens(ContractProvider provider,
      {required BigInt amount0, required BigInt amount1}) async {
    final result = await provider.get("get_expected_tokens", [
      TiInt(amount0),
      TiInt(amount1),
    ]);
    return result.stack.readBigInt();
  }

  Future<(BigInt, BigInt)> getExpectedLiquidity(ContractProvider provider,
      {required BigInt jettonAmount}) async {
    final result = await provider.get("get_expected_liquidity", [
      TiInt(jettonAmount),
    ]);
    return (result.stack.readBigInt(), result.stack.readBigInt());
  }

  Future<InternalAddress> getLpAccountAddress(ContractProvider provider,
      {required InternalAddress ownerAddress}) async {
    final result = await provider.get("get_expected_liquidity", [
      TiSlice(beginCell()
          .storeAddress(ownerAddress)
          .endCell()),
    ]);
    return result.stack.readAddress();
  }

  Future<JettonWallet> getJettonWallet(ContractProvider provider,
      {required InternalAddress ownerAddress}) async {
    final jettonWalletAddress = await getWalletAddress(ownerAddress);
    return JettonWallet.create(jettonWalletAddress);
  }

  Future getPoolData(ContractProvider provider) async {
    final result = await provider.get("get_pool_data", []);
    return (result.stack.readBigInt(), //reserve0
    result.stack.readBigInt(), // reserve1
    result.stack.readAddress(), // token0WalletAddress
    result.stack.readAddress(), // token1WalletAddress
    result.stack.readBigInt(), // lpFee
    result.stack.readBigInt(), //protocolFee
    result.stack.readBigInt(), //refFee
    result.stack.readAddress(), //protocolFeeAddress
    result.stack.readBigInt(), //collectedToken0ProtocolFee
    result.stack.readBigInt() // collectedToken1ProtocolFee
    );
  }

  Future<LpAccountV1> getLpAccount(ContractProvider provider,
      {required InternalAddress ownerAddress}) async {
    final lpAccountAddress = await getLpAccountAddress(provider, ownerAddress: ownerAddress);
    return LpAccountV1.create(lpAccountAddress);
  }

}
