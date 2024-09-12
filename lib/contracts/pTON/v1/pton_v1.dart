import 'package:stonfi/contracts/pTON/constants.dart';
import 'package:stonfi/contracts/pTON/pton.dart';
import 'package:stonfi/utils/create_jetton_transfer_message.dart';
import 'package:tonutils/tonutils.dart';

class PtonGasConstant {
  final BigInt deployWallet;

  PtonGasConstant({
    required this.deployWallet,
  });
}

class PtonV1 extends Pton {
  static PtonVersion version = PtonVersion.v1;
  static InternalAddress staticAddress =
      InternalAddress.parse("EQCM3B12QK1e4yZSf8GtBRT0aLMNyEsBc_DhVfRRtOEffLez");
  static PtonGasConstant gasConstants =
      PtonGasConstant(deployWallet: Nano.fromString('1.05'));

  PtonV1({InternalAddress? address, PtonGasConstant? gasConstants})
      : super(address ?? PtonV1.staticAddress) {
    PtonV1.gasConstants = gasConstants ?? PtonV1.gasConstants;
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

  Cell createDeployWalletBody(
      {required InternalAddress ownerAddress,
      InternalAddress? excessAddress,
      BigInt? queryId}) {
    return beginCell()
        .storeUint(PtonOpCodes.DEPLOY_WALLET_V1.op, 32)
        .storeUint(queryId ?? BigInt.zero, 64)
        .storeAddress(ownerAddress)
        .endCell();
  }

  Future<SenderArguments> getDeployWalletTxParams(
      {required InternalAddress ownerAddress,
      InternalAddress? excessAddress,
      BigInt? gasAmount,
      BigInt? queryId}) async {
    final to = this.address;

    final body = createDeployWalletBody(
      ownerAddress: ownerAddress,
      queryId: queryId,
    );

    final value = gasAmount ?? PtonV1.gasConstants.deployWallet;

    return SenderArguments(value: value, to: to, body: body);
  }
}
