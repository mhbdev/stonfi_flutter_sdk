import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/utils/create_jetton_transfer_message.dart';
import 'package:tonutils/dataformat.dart';
import 'package:tonutils/jetton.dart';
import 'package:tonutils/tonutils.dart';

class PtonV1 extends JettonMaster {
  static DexVersion version = DexVersion.v1;

  PtonV1({InternalAddress? address, required ContractProvider provider})
      : super(
            address ??
                InternalAddress.parse(
                    "EQCM3B12QK1e4yZSf8GtBRT0aLMNyEsBc_DhVfRRtOEffLez"),
            provider);

  Future<SenderArguments> getTonTransferTxParams(ContractProvider provider,
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

  sendTonTransfer(ContractProvider provider, Sender via,
      {required BigInt tonAmount,
      required InternalAddress destinationAddress,
      required InternalAddress refundAddress,
      Cell? forwardPayload,
      BigInt? forwardTonAmount,
      BigInt? queryId}) async {
    final txParams = await getTonTransferTxParams(provider,
        destinationAddress: destinationAddress,
        refundAddress: refundAddress,
        tonAmount: tonAmount,
        queryId: queryId,
        forwardPayload: forwardPayload,
        forwardTonAmount: forwardTonAmount);
    return via.send(txParams);
  }
}
