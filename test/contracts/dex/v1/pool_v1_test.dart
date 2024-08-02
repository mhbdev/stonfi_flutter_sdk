import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/stonfi.dart';
import 'package:stonfi/utils/extensions.dart';
import 'package:tonutils/dataformat.dart';

import '../../../mock_contract_provider.dart';

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

    group("getBurnTxParams", () {
      final amount = BigInt.parse("1000000000");
      final responseAddress = USER_WALLET_ADDRESS;
      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          if (methodName == 'get_wallet_address') {
            if (address.equals(POOL_ADDRESS)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOACstDZ3ATHWF//MUN1iK/rfVwlHFuhUxxdp3sB2jMtipQs2Cj5Q==")
                  .beginParse());
            }
          }

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test("should build expected tx params", () async {
        final contract = provider.open(PoolV1(POOL_ADDRESS));

        final txParams = await contract.getBurnTxParams(
          amount: amount,
          responseAddress: responseAddress,
        );

        expect(
            txParams.to.equals(
                address("EQBWWhs7gJjrC__mKG6xFf1vq4Sji3QqY4u072A7RmWxUoT1")),
            true);
        expect(
            txParams.body?.toBoc().toBase64(),
            equals(
                "te6cckEBAQEANAAAY1lfB7wAAAAAAAAAAEO5rKAIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRhaz3TA=="));
        expect(txParams.value, equals(BigInt.parse("500000000")));
      });

      test("should build expected tx params when queryId is defined", () async {
        final contract = provider.open(PoolV1(POOL_ADDRESS));

        final txParams = await contract.getBurnTxParams(
          amount: amount,
          responseAddress: responseAddress,
          queryId: BigInt.from(12345),
        );

        expect(
            txParams.to.equals(
                address("EQBWWhs7gJjrC__mKG6xFf1vq4Sji3QqY4u072A7RmWxUoT1")),
            true);
        expect(
            txParams.body?.toBoc().toBase64(),
            equals(
                "te6cckEBAQEANAAAY1lfB7wAAAAAAAAwOUO5rKAIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRGnDxRA=="));
        expect(txParams.value, equals(BigInt.parse("500000000")));
      });

      test("should build expected tx params when custom gasAmount is defined",
          () async {
        final contract = provider.open(PoolV1(POOL_ADDRESS));

        final txParams = await contract.getBurnTxParams(
          amount: amount,
          responseAddress: responseAddress,
          gasAmount: BigInt.one,
        );

        expect(
            txParams.to.equals(
                address("EQBWWhs7gJjrC__mKG6xFf1vq4Sji3QqY4u072A7RmWxUoT1")),
            true);
        expect(
            txParams.body?.toBoc().toBase64(),
            equals(
                "te6cckEBAQEANAAAY1lfB7wAAAAAAAAAAEO5rKAIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRhaz3TA=="));
        expect(txParams.value, equals(BigInt.one));
      });
    });

    group('getExpectedTokens', () {
      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeInt(BigInt.from(19));

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test("should make on-chain request and return parsed response", () async {
        final contract = provider.open(PoolV1(POOL_ADDRESS));

        final data = await contract.getExpectedTokens(
          amount0: BigInt.parse("100000"),
          amount1: BigInt.parse("200000"),
        );

        expect(data, BigInt.from(19));
      });
    });

    group("getExpectedLiquidity", () {
      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeInt(BigInt.from(128));
          stack.writeInt(BigInt.from(10128));

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test("should make on-chain request and return parsed response", () async {
        final contract = provider.open(PoolV1(POOL_ADDRESS));

        final data = await contract.getExpectedLiquidity(
          jettonAmount: BigInt.one,
        );

        expect(data.amount0, BigInt.from(128));
        expect(data.amount1, BigInt.from(10128));
      });
    });

    group("getLpAccountAddress", () {
      final ownerAddress =
          address("UQAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D_8noARLOaEAn");

      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeCell(Cell.fromBocBase64(
              "te6ccsEBAQEAJAAAAEOAH6VkyTu5g20HTCbGu1/OTfiBSIoSdeKMzW42GndI90LQv9OlMw=="));

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test("should make on-chain request and return parsed response", () async {
        final contract = provider.open(PoolV1(POOL_ADDRESS));

        final data = await contract.getLpAccountAddress(
          ownerAddress: ownerAddress,
        );

        expect(
            data.equals(
                address("EQD9KyZJ3cwbaDphNjXa_nJvxApEUJOvFGZrcbDTuke6Fs7B")),
            true);
      });
    });

    group("getPoolData", () {
      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeInt(BigInt.from(14659241047997));
          stack.writeInt(BigInt.from(1155098971931369));
          stack.writeCell(Cell.fromBocBase64(
              "te6ccsEBAQEAJAAAAEOAEPckSDVNSvvmJOKMGCE4qb+zE0NdQGXsIPpYy63RDznQToI/Aw=="));
          stack.writeCell(Cell.fromBocBase64(
              "te6ccsEBAQEAJAAAAEOAE+qvh8EqMXFOd5n96sMS0GVGtkQdC74+zQaWQuG2G/lwYlQIaw=="));
          stack.writeInt(BigInt.from(20));
          stack.writeInt(BigInt.from(10));
          stack.writeInt(BigInt.from(10));
          stack.writeCell(Cell.fromBocBase64(
              "te6ccsEBAQEAJAAAAEOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQvWZ7LQ=="));
          stack.writeInt(BigInt.from(71678297602));
          stack.writeInt(BigInt.from(3371928931127));

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test("should make on-chain request and return parsed response", () async {
        final contract = provider.open(PoolV1(POOL_ADDRESS));

        final data = await contract.getPoolData();

        expect(data.reserve0, equals(BigInt.from(14659241047997)));
        expect(data.reserve1, equals(BigInt.from(1155098971931369)));
        expect(
            data.token0WalletAddress.equals(
                address("EQCHuSJBqmpX3zEnFGDBCcVN_ZiaGuoDL2EH0sZdboh5zkwy")),
            true);
        expect(
            data.token1WalletAddress.equals(
                address("EQCfVXw-CVGLinO8z-9WGJaDKjWyIOhd8fZoNLIXDbDfy2kw")),
            true);
        expect(data.lpFee, equals(BigInt.from(20)));
        expect(data.protocolFee, equals(BigInt.from(10)));
        expect(data.refFee, equals(BigInt.from(10)));
        expect(
            data.protocolFeeAddress.equals(
                address("EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9c")),
            true);
        expect(
            data.collectedToken0ProtocolFee, equals(BigInt.from(71678297602)));
        expect(data.collectedToken1ProtocolFee,
            equals(BigInt.from(3371928931127)));
      });
    });
  });
}
