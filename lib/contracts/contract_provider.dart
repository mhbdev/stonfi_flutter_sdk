import 'package:stonfi/contracts/contract.dart';
import 'package:tonutils/dataformat.dart';
import 'package:tonutils/tonutils.dart';

class StonfiContractProvider extends ContractProvider {
  late E Function<E extends Contract>(E contract) open;

  StonfiContractProvider(super.getState, super.get, super.external, super.internal);
}

T openContract<T extends Contract>(
  T src,
  StonfiContractProvider Function({
    required InternalAddress address,
    ContractInit? init,
  }) factory,
) {
  InternalAddress address = src.address;
  ContractInit? init = src.init;

  var executor = factory(address: address, init: init);
  src.provider = executor;
  if(src is StonfiContract) {
    src.stonfiProvider = executor;
  }

  return src;
}
