import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/contracts/pTON/constants.dart';
import 'package:stonfi/contracts/pTON/v1/pton_v1.dart';
import 'package:stonfi/utils/create_jetton_transfer_message.dart';
import 'package:tonutils/dataformat.dart';
import 'package:tonutils/tonutils.dart';

class PtonGasConstant {
  final BigInt tonTransfer;

  PtonGasConstant({
    required this.tonTransfer,
  });
}

class PtonV2 extends PtonV1 {
  static PtonVersion version = PtonVersion.v1;
  static InternalAddress staticAddress =
      InternalAddress.parse("EQCM3B12QK1e4yZSf8GtBRT0aLMNyEsBc_DhVfRRtOEffLez");
  static PtonGasConstant gasConstants = PtonGasConstant(
    tonTransfer: Nano.fromString('0.01'),
  );

  PtonV2({super.address, PtonGasConstant? gasConstants}) {
    PtonV2.gasConstants = gasConstants ?? PtonV2.gasConstants;
  }

  Cell createTonTransferBody({
    required BigInt tonAmount,
    required InternalAddress refundAddress,
    Cell? forwardPayload,
    BigInt? queryId,
  }) {
    Builder b = beginCell()
        .storeUint(PtonOpCodes.TON_TRANSFER.op, 32)
        .storeUint(queryId ?? BigInt.zero, 64)
        .storeCoins(tonAmount)
        .storeAddress(refundAddress);

    if (forwardPayload != null) {
      b.storeBool(true).storeRef(forwardPayload);
    }

    return b.endCell();
  }

  @override
  Future<SenderArguments> getTonTransferTxParams(
      {required BigInt tonAmount,
      required InternalAddress destinationAddress,
      required InternalAddress refundAddress,
      Cell? forwardPayload,
      BigInt? forwardTonAmount,
      BigInt? queryId}) async {
    final to = await getWalletAddress(destinationAddress);

    final body = createTonTransferBody(
      tonAmount: tonAmount,
      refundAddress: refundAddress,
      forwardPayload: forwardPayload,
      queryId: queryId,
    );

    final value = tonAmount + (forwardTonAmount ?? BigInt.zero) + gasConstants.tonTransfer;

    return SenderArguments(value: value, to: to, body: body);
  }

  @override
  sendTonTransfer(Sender via,
      {required BigInt tonAmount,
      required InternalAddress destinationAddress,
      required InternalAddress refundAddress,
      Cell? forwardPayload,
      BigInt? forwardTonAmount,
      BigInt? queryId}) async {
    final txParams = await getTonTransferTxParams(
        destinationAddress: destinationAddress,
        refundAddress: refundAddress,
        tonAmount: tonAmount,
        queryId: queryId,
        forwardPayload: forwardPayload,
        forwardTonAmount: forwardTonAmount);
    return via.send(txParams);
  }
}
