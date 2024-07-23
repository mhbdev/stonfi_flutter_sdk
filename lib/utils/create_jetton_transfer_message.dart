
import 'package:tonutils/tonutils.dart';

createJettonTransferMessage({
  required BigInt queryId,
  required BigInt amount,
  required InternalAddress destination,
  InternalAddress? responseDestination,
  Cell? customPayload,
  required BigInt forwardTonAmount,
  Cell? forwardPayload,
}) {
  final builder = Builder();
  builder.storeUint(BigInt.from(0xf8a7ea5), 32);
  builder.storeUint(queryId, 64);
  builder.storeCoins(amount);
  builder.storeAddress(destination);
  builder.storeAddress(responseDestination);

  if(customPayload != null) {
    builder.storeBool(true);
    builder.storeRef(customPayload);
  } else {
    builder.storeBool(false);
  }

  builder.storeCoins(forwardTonAmount);

  if (forwardPayload != null) {
    builder.storeBool(true);
    builder.storeRef(forwardPayload);
  } else {
    builder.storeBool(false);
  }

  return builder.endCell();
}
