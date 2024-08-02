import 'package:stonfi/contracts/contract.dart';
import 'package:stonfi/contracts/dex/constants.dart';
import 'package:tonutils/dataformat.dart';
import 'package:tonutils/tonutils.dart';

class LpAccountGasConstant {
  final BigInt refund;
  final BigInt directAddLp;
  final BigInt resetGas;

  LpAccountGasConstant({
    required this.refund,
    required this.directAddLp,
    required this.resetGas,
  });
}

class LpAccountV1 extends StonfiContract {
  static DexVersion version = DexVersion.v1;
  static LpAccountGasConstant gasConstants = LpAccountGasConstant(
    refund: Nano.fromString('0.3'),
    directAddLp: Nano.fromString('0.3'),
    resetGas: Nano.fromString('0.3'),
  );

  LpAccountV1(InternalAddress address, {LpAccountGasConstant? gasConstants}) {
    this.address = address;

    LpAccountV1.gasConstants = gasConstants ?? LpAccountV1.gasConstants;
  }

  factory LpAccountV1.create(InternalAddress address) => LpAccountV1(address);

  Cell createRefundBody({
    BigInt? queryId,
  }) {
    return beginCell()
        .storeUint(DexOpCodes.REFUND_ME.op, 32)
        .storeUint(queryId ?? BigInt.zero, 64)
        .endCell();
  }

  SenderArguments getRefundTxParams({
    BigInt? gasAmount,
    BigInt? queryId,
  }) {
    final to = this.address;
    final body = createRefundBody(queryId: queryId);
    final value = gasAmount ?? gasConstants.refund;

    return SenderArguments(to: to, value: value, body: body);
  }

  Future<void> sendRefund(
    ContractProvider provider,
    Sender via, {
    BigInt? gasAmount,
    BigInt? queryId,
  }) async {
    final txParams = getRefundTxParams(gasAmount: gasAmount, queryId: queryId);

    return via.send(txParams);
  }

  Cell createDirectAddLiquidityBody(
      {required BigInt amount0,
      required BigInt amount1,
      BigInt? minimumLpToMint,
      BigInt? queryId}) {
    return beginCell()
        .storeUint(DexOpCodes.DIRECT_ADD_LIQUIDITY.op, 32)
        .storeUint(queryId ?? BigInt.zero, 64)
        .storeCoins(amount0)
        .storeCoins(amount1)
        .storeCoins(minimumLpToMint ?? BigInt.from(1))
        .endCell();
  }

  SenderArguments getDirectAddLiquidityTxParams({
    required BigInt amount0,
    required BigInt amount1,
    BigInt? minimumLpToMint,
    BigInt? queryId,
    BigInt? gasAmount,
  }) {
    final to = this.address;
    final body = createDirectAddLiquidityBody(
      amount0: amount0,
      amount1: amount1,
      minimumLpToMint: minimumLpToMint,
      queryId: queryId,
    );
    final value = gasAmount ?? gasConstants.directAddLp;

    return SenderArguments(to: to, value: value, body: body);
  }

  Future<void> sendDirectAddLiquidity(
    ContractProvider provider,
    Sender via, {
    required BigInt amount0,
    required BigInt amount1,
    BigInt? minimumLpToMint,
    BigInt? queryId,
    BigInt? gasAmount,
  }) async {
    final txParams = getDirectAddLiquidityTxParams(
      gasAmount: gasAmount,
      queryId: queryId,
      amount0: amount0,
      amount1: amount1,
      minimumLpToMint: minimumLpToMint,
    );

    return via.send(txParams);
  }

  Cell createResetGasBody({BigInt? queryId}) {
    return beginCell()
        .storeUint(DexOpCodes.RESET_GAS.op, 32)
        .storeUint(queryId ?? BigInt.zero, 64)
        .endCell();
  }

  SenderArguments getResetGasTxParams({
    BigInt? queryId,
    BigInt? gasAmount,
  }) {
    final to = this.address;
    final body = createResetGasBody(queryId: queryId);
    final value = gasAmount ?? gasConstants.resetGas;

    return SenderArguments(to: to, value: value, body: body);
  }

  Future<void> sendResetGas(
    ContractProvider provider,
    Sender via, {
    BigInt? queryId,
    BigInt? gasAmount,
  }) async {
    final txParams =
        getResetGasTxParams(queryId: queryId, gasAmount: gasAmount);

    return via.send(txParams);
  }

  Future<
      ({
        InternalAddress userAddress,
        InternalAddress poolAddress,
        BigInt amount0,
        BigInt amount1,
      })> getLpAccountData() async {
    final result = await stonfiProvider!.get("get_lp_account_data", []);
    return (
      userAddress: result.stack.readAddress(), // user address
      poolAddress: result.stack.readAddress(), // pool address
      amount0: result.stack.readBigInt(), // amount0
      amount1: result.stack.readBigInt(), // amount1
    );
  }
}
