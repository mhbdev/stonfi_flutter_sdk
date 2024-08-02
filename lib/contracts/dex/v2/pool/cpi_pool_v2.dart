import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/contracts/dex/v2/pool/base_pool_v2.dart';

class CpiPoolV2 extends BasePoolV2 {
  static DexType get dexType => DexType.CPI;

  CpiPoolV2(super.address);
}