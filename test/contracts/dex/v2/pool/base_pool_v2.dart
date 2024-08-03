import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/contracts/dex/v2/pool/base_pool_v2.dart';
import 'package:stonfi/utils/extensions.dart';
import 'package:tonutils/dataformat.dart';

import '../../../../mock_contract_provider.dart';

final USER_WALLET_ADDRESS =
    address("UQAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D_8noARLOaEAn");
final POOL_ADDRESS = address(
    "EQDi0bJhkvB86vEK7mjaa508xwSB4mnk8zXLdmb0AtsO4iG7"); // TestRED/TestBLUE pool

void main() {
  group("BasePoolV2", () {
    group("version", () {
      test("should have expected static value", () {
        expect(BasePoolV2.version, equals(DexVersion.v2));
      });
    });

    group('gasConstants', () {
      test("should have expected static value", () {
        expect(BasePoolV2.gasConstants.burn, equals(BigInt.from(800000000)));
        expect(BasePoolV2.gasConstants.collectFees,
            equals(BigInt.from(400000000)));
      });
    });

    group("createCollectFeesBody", () {
      test("should build expected tx body", () async {
        final contract = BasePoolV2(POOL_ADDRESS);

        final body = contract.createCollectFeesBody();

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGB/LfT0AAAAAAAAAAOHc0mQ="));
      });

      test("should build expected tx body when queryId is defined", () async {
        final contract = BasePoolV2(POOL_ADDRESS);

        final body = contract.createCollectFeesBody(
          queryId: BigInt.from(12345),
        );

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGB/LfT0AAAAAAAAwOR9czWw="));
      });
    });

    group("getCollectFeeTxParams", () {
      final provider = FakeContractProviderGetter((address, methodName, args) {
        throw UnimplementedError();
      });
      test("should build expected tx params", () async {
        final contract = provider.open(BasePoolV2(POOL_ADDRESS));

        final params = await contract.getCollectFeeTxParams();

        expect(
            params.to.equals(
                address("EQDi0bJhkvB86vEK7mjaa508xwSB4mnk8zXLdmb0AtsO4iG7")),
            equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGB/LfT0AAAAAAAAAAOHc0mQ="));
        expect(params.value, equals(BigInt.from(400000000)));
      });

      test("should build expected tx params when queryId is defined", () async {
        final contract = provider.open(BasePoolV2(POOL_ADDRESS));

        final params = contract.getCollectFeeTxParams(
          queryId: BigInt.from(12345),
        );

        expect(
            params.to.equals(
                address("EQDi0bJhkvB86vEK7mjaa508xwSB4mnk8zXLdmb0AtsO4iG7")),
            equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGB/LfT0AAAAAAAAwOR9czWw="));
        expect(params.value, equals(BigInt.from(400000000)));
      });

      test("should build expected tx params when custom gasAmount is defined",
          () async {
        final contract = provider.open(BasePoolV2(POOL_ADDRESS));

        final params = contract.getCollectFeeTxParams(
          gasAmount: BigInt.one,
        );

        expect(
            params.to.equals(
                address("EQDi0bJhkvB86vEK7mjaa508xwSB4mnk8zXLdmb0AtsO4iG7")),
            equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGB/LfT0AAAAAAAAAAOHc0mQ="));
        expect(params.value, equals(BigInt.one));
      });
    });

    group("createBurnBody", () {
      final amount = BigInt.from(1000000000);

      test("should build expected tx body", () async {
        final contract = BasePoolV2(POOL_ADDRESS);

        final body = contract.createBurnBody(
          amount: amount,
        );

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEAEwAAIVlfB7wAAAAAAAAAAEO5rKABu8koZQ=="));
      });

      test("should build expected tx body when queryId is defined", () async {
        final contract = BasePoolV2(POOL_ADDRESS);

        final body = contract.createBurnBody(
          amount: amount,
          queryId: BigInt.from(12345),
        );

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEAEwAAIVlfB7wAAAAAAAAwOUO5rKABFeXmDg=="));
      });
    });

    group("getBurnTxParams", () {
      final amount = BigInt.parse("1000000000");
      final userWalletAddress = USER_WALLET_ADDRESS;

      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          // owner address
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
        final contract = provider.open(BasePoolV2(POOL_ADDRESS));

        final params = await contract.getBurnTxParams(
          amount: amount,
          userWalletAddress: userWalletAddress,
        );

        expect(
            params.to.equals(
                address("EQBWWhs7gJjrC__mKG6xFf1vq4Sji3QqY4u072A7RmWxUoT1")),
            equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEAEwAAIVlfB7wAAAAAAAAAAEO5rKABu8koZQ=="));
        expect(params.value, equals(BigInt.from(800000000)));
      });

      test("should build expected tx params when queryId is defined", () async {
        final contract = provider.open(BasePoolV2(POOL_ADDRESS));

        final params = await contract.getBurnTxParams(
          amount: amount,
          userWalletAddress: userWalletAddress,
          queryId: BigInt.from(12345),
        );

        expect(
            params.to.equals(
                address('EQBWWhs7gJjrC__mKG6xFf1vq4Sji3QqY4u072A7RmWxUoT1')),
            equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEAEwAAIVlfB7wAAAAAAAAwOUO5rKABFeXmDg=="));
        expect(params.value, equals(BigInt.from(800000000)));
      });

      test("should build expected tx params when custom gasAmount is defined",
          () async {
        final contract = provider.open(BasePoolV2(POOL_ADDRESS));

        final params = await contract.getBurnTxParams(
          amount: amount,
          userWalletAddress: userWalletAddress,
          gasAmount: BigInt.one,
        );

        expect(
            params.to.equals(
                address("EQBWWhs7gJjrC__mKG6xFf1vq4Sji3QqY4u072A7RmWxUoT1")),
            equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEAEwAAIVlfB7wAAAAAAAAAAEO5rKABu8koZQ=="));
        expect(params.value, equals(BigInt.one));
      });
    });

    group("getLpAccountAddress", () {
      final ownerAddress = USER_WALLET_ADDRESS;

      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeSlice(Cell.fromBocBase64(
                  "te6cckEBAQEAJAAAQ4AAB5/Ovamu/bOPeMhsGc3XW0I0uNxe2kUSAaNuD00KyZBJLKC6")
              .beginParse());

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test("should make on-chain request and return parsed response", () async {
        final contract = provider.open(BasePoolV2(POOL_ADDRESS));

        final data = await contract.getLpAccountAddress(
          ownerAddress: ownerAddress,
        );

        expect(
            data.equals(
                address("EQAAPP517U137Zx7xkNgzm662hGlxuL20iiQDRtwemhWTPLx")),
            equals(true));
      });
    });

    group("getPoolType", () {
      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeString('constant_product');

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test("should make on-chain request and return parsed response", () async {
        final contract = provider.open(BasePoolV2(POOL_ADDRESS));

        final type = await contract.getPoolType();

        expect(type, equals(DexType.CPI));
      });
    });

    group("getPoolData", () {
      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeInt(BigInt.zero);
          stack.writeCell(Cell.fromBocBase64(
              "te6cckEBAQEAJAAAQ4ATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAq9P4f"));
          stack.writeInt(BigInt.from(4986244178));
          stack.writeInt(BigInt.from(4408450497));
          stack.writeInt(BigInt.from(5646981229));
          stack.writeCell(Cell.fromBocBase64(
              "te6cckEBAQEAJAAAQ4AFImSaUo+dFf1OYl8dtYp9Zj6M0s4JKV4Dgg9WfZm54vCRWjIN"));
          stack.writeCell(Cell.fromBocBase64(
              "te6cckEBAQEAJAAAQ4ATmaZ7TLWAsPlzzyZBHUychwiCFGUXrTsOROB1sQcwtxDOko/O"));
          stack.writeInt(BigInt.from(20));
          stack.writeInt(BigInt.from(10));
          stack.writeCell(Cell.fromBocBase64("te6cckEBAQEAAwAAASCUQYZV"));
          stack.writeInt(BigInt.from(2519317));
          stack.writeInt(BigInt.from(514527));

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test("should make on-chain request and return parsed response", () async {
        final contract = provider.open(BasePoolV2(POOL_ADDRESS));

        final data = await contract.getPoolData();

        expect(data.isLocked, equals(false));
        expect(
            data.routerAddress.equals(
                address("EQCas2p939ESyXM_BzFJzcIe3GD5S0tbjJDj6EBVn-SPsPKH")),
            equals(true));
        expect(data.totalSupplyLP, equals(BigInt.from(4986244178)));
        expect(data.reserve0, equals(BigInt.from(4408450497)));
        expect(data.reserve1, equals(BigInt.from(5646981229)));
        expect(
            data.token0WalletAddress.equals(
                address("EQApEyTSlHzor-pzEvjtrFPrMfRmlnBJSvAcEHqz7M3PF3Tb")),
            equals(true));
        expect(
            data.token1WalletAddress.equals(
                address("EQCczTPaZawFh8ueeTII6mTkOEQQoyi9adhyJwOtiDmFuB9j")),
            equals(true));
        expect(data.lpFee, equals(BigInt.from(20)));
        expect(data.protocolFee, equals(BigInt.from(10)));
        expect(data.protocolFeeAddress, equals(null));
        expect(data.collectedToken0ProtocolFee, equals(BigInt.from(2519317)));
        expect(data.collectedToken1ProtocolFee, equals(BigInt.from(514527)));
      });
    });
  });
}
