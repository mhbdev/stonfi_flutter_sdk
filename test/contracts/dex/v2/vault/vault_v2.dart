import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/contracts/dex/v2/vault/vault_v2.dart';
import 'package:stonfi/utils/extensions.dart';
import 'package:tonutils/dataformat.dart';

import '../../../../mock_contract_provider.dart';

final USER_WALLET_ADDRESS =
    address("UQAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D_8noARLOaEAn");
final VAULT_ADDRESS = address(
    "EQDIAOYrxwbAI1m3wUJlvJVRoZuxO_TZmavNVj-TBDe0LiLR"); // Vault for `USER_WALLET_ADDRESS` wallet and TestRED token

void main() {
  group('VaultV2', () {
    group("version", () {
      test("should have expected static value", () {
        expect(VaultV2.version, equals(DexVersion.v2));
      });
    });

    group("gasConstants", () {
      test("should have expected static value", () {
        expect(
            VaultV2.gasConstants.withdrawFee, equals(BigInt.from(300000000)));
      });
    });

    group("createWithdrawFeeBody", () {
      test("should build expected tx body", () async {
        final contract = VaultV2(VAULT_ADDRESS);

        final body = contract.createWithdrawFeeBody();

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGEXtLccAAAAAAAAAAJcJAj4="));
      });

      test("should build expected tx body when queryId is defined", () async {
        final contract = VaultV2(VAULT_ADDRESS);

        final body = contract.createWithdrawFeeBody(
          queryId: BigInt.from(12345),
        );

        expect(body.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGEXtLccAAAAAAAAwOWmJHTY="));
      });
    });

    group("getWithdrawFeeTxParams", () {
      final provider = FakeContractProviderGetter((address, methodName, args) {
        throw UnimplementedError();
      });
      test("should build expected tx params", () async {
        final contract = provider.open(VaultV2(VAULT_ADDRESS));

        final params = await contract.getWithdrawFeeTxParams();

        expect(params.to.equals(VAULT_ADDRESS), equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGEXtLccAAAAAAAAAAJcJAj4="));
        expect(params.value, equals(VaultV2.gasConstants.withdrawFee));
      });

      test("should build expected tx params when queryId is defined", () async {
        final contract = provider.open(VaultV2(VAULT_ADDRESS));

        final params = await contract.getWithdrawFeeTxParams(
          queryId: BigInt.from(12345),
        );

        expect(params.to.equals(VAULT_ADDRESS), equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGEXtLccAAAAAAAAwOWmJHTY="));
        expect(params.value, VaultV2.gasConstants.withdrawFee);
      });

      test("should build expected tx params when custom gasAmount is defined",
          () async {
        final contract = provider.open(VaultV2(VAULT_ADDRESS));

        final params = await contract.getWithdrawFeeTxParams(
          gasAmount: BigInt.one,
        );

        expect(params.to.equals(VAULT_ADDRESS), equals(true));
        expect(params.body?.toBoc().toBase64(),
            equals("te6cckEBAQEADgAAGEXtLccAAAAAAAAAAJcJAj4="));
        expect(params.value, equals(BigInt.one));
      });
    });

    group("getVaultData", () {
      test("should make on-chain request and return parsed response", () async {
        final provider = FakeContractProviderGetter(
          (address, methodName, args) {
            final stack = TupleBuilder();
            stack.writeCell(Cell.fromBocBase64(
                "te6cckEBAQEAJAAAQ4ACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRCUZNla"));
            stack.writeCell(Cell.fromBocBase64(
                "te6cckEBAQEAJAAAQ4AZd9jNEu8dzORwCo3lq1hM9p2LwjKwjSwTbaUbDUiFNzBy9LMe"));
            stack.writeCell(Cell.fromBocBase64(
                "te6cckEBAQEAJAAAQ4ATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAq9P4f"));
            stack.writeInt(BigInt.one);

            return Future.value(ContractGetMethodResult(
              stack: TupleReader(stack.build()),
            ));
          },
        );

        final contract = provider.open(VaultV2(VAULT_ADDRESS));

        final data = await contract.getVaultData();

        expect(
            data.ownerAddress.equals(
                address("EQAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D_8noARLOaB3i")),
            equals(true));
        expect(
            data.tokenAddress.equals(
                address("EQDLvsZol3juZyOAVG8tWsJntOxeEZWEaWCbbSjYakQpuTjz")),
            equals(true));
        expect(
            data.routerAddress.equals(
                address("EQCas2p939ESyXM_BzFJzcIe3GD5S0tbjJDj6EBVn-SPsPKH")),
            equals(true));
        expect(data.depositedAmount, equals(BigInt.one));
      });
    });
  });
}
