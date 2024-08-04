import 'package:tonutils/dataformat.dart';
import 'package:tonutils/jetton.dart';

abstract class Pton extends JettonMaster {
  Pton(super.address);

  Future<SenderArguments> getTonTransferTxParams(
      {required BigInt tonAmount,
        required InternalAddress destinationAddress,
        required InternalAddress refundAddress,
        Cell? forwardPayload,
        BigInt? forwardTonAmount,
        BigInt? queryId});

  Future<void> sendTonTransfer(Sender via,
      {required BigInt tonAmount,
        required InternalAddress destinationAddress,
        required InternalAddress refundAddress,
        Cell? forwardPayload,
        BigInt? forwardTonAmount,
        BigInt? queryId});
}