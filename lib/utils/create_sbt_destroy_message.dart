import 'package:tonutils/tonutils.dart';

createSbtDestroyMessage({
  BigInt? queryId
}) {
return beginCell()
    .storeUint(BigInt.from(0x1f04537a), 32)
    .storeUint(queryId ?? BigInt.zero, 64)
    .endCell();
}
