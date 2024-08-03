import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/contracts/dex/v2/lp_account/lp_account_v2.dart';
import 'package:stonfi/utils/extensions.dart';
import 'package:tonutils/dataformat.dart';

import '../../../../mock_contract_provider.dart';

final USER_WALLET_ADDRESS =
    address("UQAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D_8noARLOaEAn");
final LP_ACCOUNT_ADDRESS = address(
    "EQAAPP517U137Zx7xkNgzm662hGlxuL20iiQDRtwemhWTPLx"); // LP account of `USER_WALLET_ADDRESS` wallet for TestRED/TestBLUE pool

void main() {
  group('LpAccountV2', () {
    group("version", () {
      test("should have expected static value", () {
        expect(LpAccountV2.version, equals(DexVersion.v2));
      });
    });

    group("gasConstants", () {
      test("should have expected static value", () {
        expect(LpAccountV2.gasConstants.directAddLp,
            equals(BigInt.from(300000000)));
        expect(LpAccountV2.gasConstants.refund, equals(BigInt.from(800000000)));
        expect(
            LpAccountV2.gasConstants.resetGas, equals(BigInt.from(20000000)));
      });
    });

    group('constructor', () {
      test("should create an instance of LpAccountV2", () {
        final contract = LpAccountV2.create(LP_ACCOUNT_ADDRESS);
        expect(contract, isInstanceOf<LpAccountV2>());
      });

      test("should create an instance of LpAccountV2 with given gasConstants",
          () {
        final gasConstants = LpAccountGasConstant(
          refund: BigInt.one,
          directAddLp: BigInt.two,
          resetGas: BigInt.from(3),
        );

        final contract =
            LpAccountV2(LP_ACCOUNT_ADDRESS, gasConstants: gasConstants);

        expect(LpAccountV2.gasConstants.directAddLp, equals(BigInt.two));
        expect(LpAccountV2.gasConstants.refund, equals(BigInt.one));
        expect(LpAccountV2.gasConstants.resetGas, equals(BigInt.from(3)));
      });
    });

    group('createRefundBody', () {
      test("should build expected tx body", () async {
        final contract = LpAccountV2.create(LP_ACCOUNT_ADDRESS);

        final body = contract.createRefundBody();

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADwAAGQvz9EcAAAAAAAAAACCVqe6q"));
      });

      test("should build expected tx body", () async {
        final contract = LpAccountV2.create(LP_ACCOUNT_ADDRESS);

        final body = contract.createRefundBody(queryId: BigInt.from(12345));

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADwAAGQvz9EcAAAAAAAAwOSBHZvD1"));
      });
    });

    group('getRefundTxParams', () {
      final client = FakeContractProviderGetter((address, methodName, args) {
        throw UnimplementedError();
      });

      test('should build expected tx params', () {
        final contract = client.open(LpAccountV2(LP_ACCOUNT_ADDRESS));
        final params = contract.getRefundTxParams();

        expect(params.to.equals(LP_ACCOUNT_ADDRESS), equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADwAAGQvz9EcAAAAAAAAAACCVqe6q"));
        expect(params.value, equals(LpAccountV2.gasConstants.refund));
      });

      test("should build expected tx params when queryId is defined", () async {
        final contract = client.open(LpAccountV2.create(LP_ACCOUNT_ADDRESS));

        final params = contract.getRefundTxParams(
          queryId: BigInt.from(12345),
        );

        expect(params.to.equals(LP_ACCOUNT_ADDRESS), equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADwAAGQvz9EcAAAAAAAAwOSBHZvD1"));
        expect(params.value, equals(LpAccountV2.gasConstants.refund));
      });

      test("should build expected tx params when custom gasAmount is defined",
          () async {
        final contract = client.open(LpAccountV2.create(LP_ACCOUNT_ADDRESS));

        final params = contract.getRefundTxParams(
          gasAmount: BigInt.one,
        );

        expect(params.to.equals(LP_ACCOUNT_ADDRESS), equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADwAAGQvz9EcAAAAAAAAAACCVqe6q"));
        expect(params.value, equals(BigInt.one));
      });
    });

    group("createDirectAddLiquidityBody", () {
      final userWalletAddress = USER_WALLET_ADDRESS;
      final amount0 = BigInt.parse("1000000000");
      final amount1 = BigInt.parse("2000000000");

      test("should build expected tx body", () async {
        final contract = LpAccountV2.create(LP_ACCOUNT_ADDRESS);

        final body = contract.createDirectAddLiquidityBody(
          userWalletAddress: userWalletAddress,
          amount0: amount0,
          amount1: amount1,
        );

        expect(
            body.toBoc().toBase64(),
            equals(
                "te6cckEBAgEAgQABcUz4KAMAAAAAAAAAAEO5rKAEdzWUABAQgAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNCAEAhYACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaJUKwEU"));
      });

      test("should build expected tx body when queryId is defined", () async {
        final contract = LpAccountV2.create(LP_ACCOUNT_ADDRESS);

        final body = contract.createDirectAddLiquidityBody(
          userWalletAddress: userWalletAddress,
          amount0: amount0,
          amount1: amount1,
          queryId: BigInt.from(12345),
        );

        expect(
            body.toBoc().toBase64(),
            equals(
                "te6cckEBAgEAgQABcUz4KAMAAAAAAAAwOUO5rKAEdzWUABAQgAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNCAEAhYACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaI6Vjui"));
      });

      test("should build expected tx body when minimumLpToMint is defined",
          () async {
        final contract = LpAccountV2.create(LP_ACCOUNT_ADDRESS);

        final body = contract.createDirectAddLiquidityBody(
          userWalletAddress: userWalletAddress,
          amount0: amount0,
          amount1: amount1,
          minimumLpToMint: BigInt.from(300),
        );

        expect(
            body.toBoc().toBase64(),
            equals(
                "te6cckEBAgEAggABc0z4KAMAAAAAAAAAAEO5rKAEdzWUACASwIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzQgBAIWAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmiXyA3Mw=="));
      });
    });

    group("getDirectAddLiquidityTxParams", () {
      final client = FakeContractProviderGetter((address, methodName, args) {
        throw UnimplementedError();
      });

      final userWalletAddress = USER_WALLET_ADDRESS;
      final amount0 = BigInt.one;
      final amount1 = BigInt.two;

      test("should build expected tx params", () async {
        final contract = client.open(LpAccountV2.create(LP_ACCOUNT_ADDRESS));

        final params = contract.getDirectAddLiquidityTxParams(
          userWalletAddress: userWalletAddress,
          amount0: amount0,
          amount1: amount1,
        );

        expect(params.to.equals(LP_ACCOUNT_ADDRESS), equals(true));
        expect(
            params.body?.toBoc().toBase64(),
            equals(
                "te6cckEBAgEAewABZUz4KAMAAAAAAAAAABARAhAQgAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNCAEAhYACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaIG6kbG"));
        expect(params.value, equals(LpAccountV2.gasConstants.directAddLp));
      });

      test("should build expected tx params when queryId is defined", () async {
        final contract = client.open(LpAccountV2.create(LP_ACCOUNT_ADDRESS));

        final params = contract.getDirectAddLiquidityTxParams(
          userWalletAddress: userWalletAddress,
          amount0: amount0,
          amount1: amount1,
          queryId: BigInt.from(12345),
        );

        expect(params.to.equals(LP_ACCOUNT_ADDRESS), equals(true));
        expect(
            params.body?.toBoc().toBase64(),
            equals(
                "te6cckEBAgEAewABZUz4KAMAAAAAAAAwORARAhAQgAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNCAEAhYACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaIeyYa1"));
        expect(params.value, equals(LpAccountV2.gasConstants.directAddLp));
      });

      test("should build expected tx params when minimumLpToMint is defined",
          () async {
        final contract = client.open(LpAccountV2.create(LP_ACCOUNT_ADDRESS));

        final params = contract.getDirectAddLiquidityTxParams(
          userWalletAddress: userWalletAddress,
          amount0: amount0,
          amount1: amount1,
          minimumLpToMint: BigInt.from(3),
        );

        expect(params.to.equals(LP_ACCOUNT_ADDRESS), equals(true));
        expect(
            params.body?.toBoc().toBase64(),
            equals(
                "te6cckEBAgEAewABZUz4KAMAAAAAAAAAABARAhAwgAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNCAEAhYACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaJ+Mo0t"));
        expect(params.value, equals(LpAccountV2.gasConstants.directAddLp));
      });

      test("should build expected tx params when custom gasAmount is defined",
          () async {
        final contract = client.open(LpAccountV2.create(LP_ACCOUNT_ADDRESS));

        final params = contract.getDirectAddLiquidityTxParams(
          userWalletAddress: userWalletAddress,
          amount0: amount0,
          amount1: amount1,
          gasAmount: BigInt.one,
        );

        expect(
            params.to.equals(
                address('EQAAPP517U137Zx7xkNgzm662hGlxuL20iiQDRtwemhWTPLx')),
            equals(true));
        expect(
            params.body?.toBoc().toBase64(),
            equals(
                "te6cckEBAgEAewABZUz4KAMAAAAAAAAAABARAhAQgAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNCAEAhYACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaIG6kbG"));
        expect(params.value, equals(BigInt.one));
      });
    });

    group("createResetGasBody", () {
      test("should build expected tx body", () async {
        final contract = LpAccountV2.create(LP_ACCOUNT_ADDRESS);

        final body = contract.createResetGasBody();

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGEKg+0MAAAAAAAAAAPc9hrQ="));
      });

      test("should build expected tx body when queryId is defined", () async {
        final contract = LpAccountV2.create(LP_ACCOUNT_ADDRESS);

        final body = contract.createResetGasBody(queryId: BigInt.from(12345));

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGEKg+0MAAAAAAAAwOQm9mbw="));
      });
    });

    group("getResetGasTxParams", () {
      final client = FakeContractProviderGetter((address, methodName, args) {
        throw UnimplementedError();
      });
      test("should build expected tx params", () async {
        final contract = client.open(LpAccountV2.create(LP_ACCOUNT_ADDRESS));

        final params = contract.getResetGasTxParams();

        expect(params.to.equals(LP_ACCOUNT_ADDRESS), equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGEKg+0MAAAAAAAAAAPc9hrQ="));
        expect(params.value, equals(LpAccountV2.gasConstants.resetGas));
      });

      test("should build expected tx params when queryId is defined", () async {
        final contract = client.open(LpAccountV2.create(LP_ACCOUNT_ADDRESS));

        final params = contract.getResetGasTxParams(
          queryId: BigInt.from(12345),
        );

        expect(params.to.equals(LP_ACCOUNT_ADDRESS), equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGEKg+0MAAAAAAAAwOQm9mbw="));
        expect(params.value, equals(LpAccountV2.gasConstants.resetGas));
      });
    });

    group("getLpAccountData", () {
      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeCell(Cell.fromBocBase64(
              "te6ccsEBAQEAJAAAAEOAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QY+4g6g=="));
          stack.writeCell(Cell.fromBocBase64(
              "te6cckEBAQEAJAAAQ4AcWjZMMl4PnV4hXc0bTXOnmOCQPE08nma5bszegFth3FBjJd6+"));
          stack.writeInt(BigInt.zero);
          stack.writeInt(BigInt.zero);

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      final contract = provider.open(LpAccountV2.create(LP_ACCOUNT_ADDRESS));

      test('should make on-chain request and return parsed response', () async {
        final data = await contract.getLpAccountData();

        expect(
            data.userAddress.equals(
                address('EQAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D_8noARLOaB3i')),
            equals(true));
        expect(
            data.poolAddress.equals(
                address('EQDi0bJhkvB86vEK7mjaa508xwSB4mnk8zXLdmb0AtsO4iG7')),
            equals(true));
        expect(data.amount0, equals(BigInt.zero));
        expect(data.amount1, equals(BigInt.zero));
      });
    });
  });
}
