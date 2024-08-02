import 'package:flutter_test/flutter_test.dart';
import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/stonfi.dart';
import 'package:stonfi/utils/extensions.dart';
import 'package:tonutils/dataformat.dart';

final POOL_ADDRESS = address(
    "EQCl-ax-5QC06ub096s2bqTbhYZWigZ1-FkJm2IVIMSazp7U"); // STON/GEMSTON pool
final USER_WALLET_ADDRESS =
    address("UQAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D_8noARLOaEAn");

void main() {
  group('PoolV1', () {
    group('version', () {
      test('should have expected static value',
          () => expect(PoolV1.version, DexVersion.v1));
    });

    group("gasConstants", () {
      test("should have expected static value", () {
        expect(PoolV1.gasConstants.burn, BigInt.parse("500000000"));
        expect(PoolV1.gasConstants.collectFees, BigInt.parse("1100000000"));
      });
    });

    group("create", () {
      test("should create an instance of PoolV1 from address", () {
        final contract = PoolV1(POOL_ADDRESS);

        expect(contract, isInstanceOf<PoolV1>());
      });
    });

    group("createCollectFeesBody", () {
      test("should build expected tx body", () async {
        final contract = PoolV1(POOL_ADDRESS);

        final body = contract.createCollectFeesBody();

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGB/LfT0AAAAAAAAAAOHc0mQ="));
      });

      test("should build expected tx body when queryId is defined", () async {
        final contract = PoolV1(POOL_ADDRESS);

        final body = contract.createCollectFeesBody(
          queryId: BigInt.from(12345),
        );

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGB/LfT0AAAAAAAAwOR9czWw="));
      });
    });

    group("getCollectFeeTxParams", () {
      final provider = Client();

      test("should build expected tx params", () async {
        final contract = provider.open(PoolV1(POOL_ADDRESS));

        final txParams = contract.getCollectFeeTxParams();

        expect(
            txParams.to.equals(
                address("EQCl-ax-5QC06ub096s2bqTbhYZWigZ1-FkJm2IVIMSazp7U")),
            true);
        expect(txParams.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGB/LfT0AAAAAAAAAAOHc0mQ="));
        expect(txParams.value, equals(BigInt.parse("1100000000")));
      });

      test("should build expected tx params when queryId is defined", () async {
        final contract = provider.open(PoolV1(POOL_ADDRESS));

        final txParams = contract.getCollectFeeTxParams(
          queryId: BigInt.from(12345),
        );

        expect(
            txParams.to.equals(
                address("EQCl-ax-5QC06ub096s2bqTbhYZWigZ1-FkJm2IVIMSazp7U")),
            true);
        expect(txParams.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGB/LfT0AAAAAAAAwOR9czWw="));
        expect(txParams.value, equals(BigInt.parse("1100000000")));
      });

      test("should build expected tx params when custom gasAmount is defined",
          () async {
        final contract = provider.open(PoolV1(POOL_ADDRESS));

        final txParams = contract.getCollectFeeTxParams(
          gasAmount: BigInt.one,
        );

        expect(
            txParams.to.equals(
                address("EQCl-ax-5QC06ub096s2bqTbhYZWigZ1-FkJm2IVIMSazp7U")),
            true);
        expect(txParams.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGB/LfT0AAAAAAAAAAOHc0mQ="));
        expect(txParams.value, equals(BigInt.one));
      });
    });

    group("createBurnBody", () {
      final amount = BigInt.parse("1000000000");
      final responseAddress = USER_WALLET_ADDRESS;

      test("should build expected tx body", () async {
        final contract = PoolV1(POOL_ADDRESS);

        final body = contract.createBurnBody(
          amount: amount,
          responseAddress: responseAddress,
        );

        expect(
            body.toBoc().toBase64(),
            equals(
                "te6cckEBAQEANAAAY1lfB7wAAAAAAAAAAEO5rKAIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRhaz3TA=="));
      });
    });
  });
}
