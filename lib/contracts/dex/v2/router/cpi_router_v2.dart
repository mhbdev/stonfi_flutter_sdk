import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/contracts/dex/v2/pool/base_pool_v2.dart';
import 'package:stonfi/contracts/dex/v2/router/base_router_v2.dart';

class CpiRouterV2 extends BaseRouterV2 {
  static DexType get dexType => DexType.CPI;

  CpiRouterV2({required super.address});
}