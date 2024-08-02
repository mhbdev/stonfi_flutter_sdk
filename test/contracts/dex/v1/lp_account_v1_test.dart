import 'package:flutter_test/flutter_test.dart';
import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/stonfi.dart';
import 'package:stonfi/utils/extensions.dart';
import 'package:tonutils/dataformat.dart';

import '../../../mock_contract_provider.dart';

const LP_ACCOUNT_ADDRESS = "EQD9KyZJ3cwbaDphNjXa_nJvxApEUJOvFGZrcbDTuke6Fs7B";

void main() {
  group('LpAccountV1', () {
    group('version', () {
      test('should have expected static value',
          () => expect(LpAccountV1.version, DexVersion.v1));
    });

    group("gasConstants", () {
      test("should have expected static value", () {
        expect(LpAccountV1.gasConstants.directAddLp, BigInt.parse("300000000"));
        expect(LpAccountV1.gasConstants.refund, BigInt.parse("300000000"));
        expect(LpAccountV1.gasConstants.resetGas, BigInt.parse("300000000"));
      });
    });

    group("create", () {
      test("should create an instance of LpAccountV1 from address", () {
        final contract =
            LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS));

        expect(contract, isInstanceOf<LpAccountV1>());
      });
    });

    group("createRefundBody", () {
      test("should build expected tx body", () async {
        final contract =
            LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS));

        final body = contract.createRefundBody();

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGAvz9EcAAAAAAAAAANCoHB4="));
      });

      test("should build expected tx body when queryId is defined", () async {
        final contract =
            LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS));

        final body = contract.createRefundBody(
          queryId: BigInt.from(12345),
        );

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGAvz9EcAAAAAAAAwOS4oAxY="));
      });
    });

    group("getRefundTxParams", () {
      final client = Client();

      test("should build expected tx params", () async {
        final contract = client.open<LpAccountV1>(
            LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS)));

        final txParams = contract.getRefundTxParams();

        expect(txParams.to, contract.address);
        expect(txParams.body!.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGAvz9EcAAAAAAAAAANCoHB4="));
        expect(txParams.value, LpAccountV1.gasConstants.refund);
      });
    });

    group('createDirectAddLiquidityBody', () {
      final amount0 = BigInt.parse("1000000000");
      final amount1 = BigInt.parse("2000000000");

      test('should build expected tx body', () {
        final contract = LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS));
        final body = contract.createDirectAddLiquidityBody(amount0: amount0, amount1: amount1);
        expect(body.toBoc().toBase64(), equals("te6cckEBAQEAGQAALUz4KAMAAAAAAAAAAEO5rKAEdzWUABAYcHfdXg=="));
      });

      test('should build expected tx body when minimumLpToMint is defined', () {
        final contract = LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS));
        final body = contract.createDirectAddLiquidityBody(amount0: amount0, amount1: amount1, minimumLpToMint: BigInt.parse("300"));
        expect(body.toBoc().toBase64(), equals("te6cckEBAQEAGgAAL0z4KAMAAAAAAAAAAEO5rKAEdzWUACASyH+t4/4="));
      });
    });

    group('getDirectAddLiquidityTxParams', () {
      final amount0 = BigInt.one;
      final amount1 = BigInt.two;

      final client = Client();

      test('should build expected tx params', () {
        final contract = client.open(LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS)));
        final txParams = contract.getDirectAddLiquidityTxParams(amount0: amount0, amount1: amount1);

        expect(txParams.to, contract.address);
        expect(txParams.body!.toBoc().toBase64(),
            equals("te6cckEBAQEAEwAAIUz4KAMAAAAAAAAAABARAhAYcJq3kQ=="));
        expect(txParams.value, LpAccountV1.gasConstants.directAddLp);
      });
    });

    group('createResetGasBody', () {
      test('should build expected tx body', () {
        final contract = LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS));
        final body = contract.createResetGasBody();
        expect(body.toBoc().toBase64(), equals("te6cckEBAQEADgAAGEKg+0MAAAAAAAAAAPc9hrQ="));
      });

      test('should build expected tx body when queryId is defined', () {
        final contract = LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS));
        final body = contract.createResetGasBody(queryId: BigInt.from(12345));
        expect(body.toBoc().toBase64(), equals("te6cckEBAQEADgAAGEKg+0MAAAAAAAAwOQm9mbw="));
      });
    });

    group("getResetGasTxParams", () {
      final client = Client();

      test("should build expected tx params", () async {
        final contract = client.open<LpAccountV1>(
            LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS)));

        final txParams = contract.getResetGasTxParams();

        expect(txParams.to, contract.address);
        expect(txParams.body!.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGEKg+0MAAAAAAAAAAPc9hrQ="));
        expect(txParams.value, LpAccountV1.gasConstants.resetGas);
      });

      test("should build expected tx params when queryId is defined", () async {
        final contract = client.open<LpAccountV1>(
            LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS)));

        final txParams = contract.getResetGasTxParams(queryId: BigInt.from(12345));

        expect(txParams.to, contract.address);
        expect(txParams.body!.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGEKg+0MAAAAAAAAwOQm9mbw="));
        expect(txParams.value, LpAccountV1.gasConstants.resetGas);
      });
    });

    group('getLpAccountData', () {
      test("should make on-chain request and return parsed response", () async {
        final client = FakeContractProviderGetter(
              (address, methodName, args) {
            final stack = TupleBuilder();
            stack.writeCell(Cell.fromBocBase64("te6ccsEBAQEAJAAAAEOAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QY+4g6g=="));
            stack.writeCell(Cell.fromBocBase64("te6ccsEBAQEAJAAAAEOAFL81j9ygFp1c3p71Zs3Um3CwytFAzr8LITNsQqQYk1nQDFEwYA=="));
            stack.writeInt(BigInt.zero);
            stack.writeInt(BigInt.zero);

            return Future.value(ContractGetMethodResult(
              stack: TupleReader(stack.build()),
            ));
          },
        );

        final contract = client.open(LpAccountV1.create(InternalAddress.parse(LP_ACCOUNT_ADDRESS)));

        final data = await contract.getLpAccountData();
        expect(data.userAddress.equals(InternalAddress.parse("EQAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D_8noARLOaB3i")), true);
        expect(data.poolAddress.equals(InternalAddress.parse("EQCl-ax-5QC06ub096s2bqTbhYZWigZ1-FkJm2IVIMSazp7U")), true);
        expect(data.amount0, equals(BigInt.zero));
        expect(data.amount1, equals(BigInt.zero));
      });

    });
  });
}
