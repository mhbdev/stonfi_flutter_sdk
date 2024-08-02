import 'package:stonfi/client/client.dart';
import 'package:tonutils/dataformat.dart';

class FakeContractProviderGetter extends Client {
  final Future<ContractGetMethodResult> Function(
      InternalAddress address, String methodName, List<TupleItem> args) calcGet;

  FakeContractProviderGetter(this.calcGet);

  @override
  Future<({int gasUsed, TupleReader stack})> runMethod(
      InternalAddress address, String methodName,
      [List<TupleItem> stack = const <TupleItem>[]]) async {
    return (gasUsed: 0, stack: (await calcGet(address, methodName, stack)).stack);
  }
}
