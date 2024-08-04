import 'package:stonfi/contracts/pTON/constants.dart';
import 'package:stonfi/contracts/pTON/pton.dart';
import 'package:stonfi/utils/create_jetton_transfer_message.dart';
import 'package:tonutils/tonutils.dart';

class PtonV1 extends Pton {
  static PtonVersion version = PtonVersion.v1;
  static InternalAddress staticAddress =
      InternalAddress.parse("EQCM3B12QK1e4yZSf8GtBRT0aLMNyEsBc_DhVfRRtOEffLez");

  PtonV1({InternalAddress? address}) : super(address ?? PtonV1.staticAddress) {
    if (address != null) {
      PtonV1.staticAddress = address;
    }
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

    final body = createJettonTransferMessage(
      queryId: queryId ?? BigInt.zero,
      amount: tonAmount,
      destination: destinationAddress,
      forwardTonAmount: forwardTonAmount ?? BigInt.zero,
      forwardPayload: forwardPayload,
    );

    final value = tonAmount + (forwardTonAmount ?? BigInt.zero);

    return SenderArguments(value: value, to: to, body: body);
  }

  @override
  Future<void> sendTonTransfer(Sender via,
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
