import 'package:stonfi/contracts/contract_provider.dart';
import 'package:tonutils/dataformat.dart';

abstract class StonfiContract extends Contract {
  StonfiContractProvider? stonfiProvider;
}
