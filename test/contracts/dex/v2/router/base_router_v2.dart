import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/contracts/dex/v2/pool/pool_v2.dart';
import 'package:stonfi/contracts/dex/v2/router/base_router_v2.dart';
import 'package:stonfi/contracts/dex/v2/vault/vault_v2.dart';
import 'package:stonfi/contracts/pTON/v1/pton_v1.dart';
import 'package:stonfi/utils/extensions.dart';
import 'package:tonutils/dataformat.dart';

import '../../../../mock_contract_provider.dart';

const USER_WALLET_ADDRESS = "UQAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D_8noARLOaEAn";
final ROUTER_ADDRESS =
    address("kQCas2p939ESyXM_BzFJzcIe3GD5S0tbjJDj6EBVn-SPsEkN");
const OFFER_JETTON_ADDRESS =
    "kQDLvsZol3juZyOAVG8tWsJntOxeEZWEaWCbbSjYakQpuYN5"; // TestRED
const ASK_JETTON_ADDRESS =
    "kQB_TOJSB7q3-Jm1O8s0jKFtqLElZDPjATs5uJGsujcjznq3"; // TestBLUE

final PTON_CONTRACT = PtonV1(
  address: address("kQAcOvXSnnOhCdLYc6up2ECYwtNNTzlmOlidBeCs5cFPV7AM"),
);

void main() {
  group('BaseRouterV2', () {
    group('version', () {
      test('should have expected static value',
          () => expect(BaseRouterV2.version, DexVersion.v2));
    });

    group('gasConstants', () {
      test('should have expected static values', () {
        expect(BaseRouterV2.gasConstants.provideLpJetton.forwardGasAmount,
            BigInt.parse('235000000'));

        expect(BaseRouterV2.gasConstants.provideLpJetton.gasAmount,
            BigInt.parse('300000000'));

        expect(BaseRouterV2.gasConstants.provideLpTon.forwardGasAmount,
            BigInt.parse('300000000'));

        expect(BaseRouterV2.gasConstants.swapJettonToJetton.forwardGasAmount,
            BigInt.parse('240000000'));

        expect(BaseRouterV2.gasConstants.swapJettonToJetton.gasAmount,
            BigInt.parse('300000000'));

        expect(BaseRouterV2.gasConstants.swapJettonToTon.forwardGasAmount,
            BigInt.parse('240000000'));

        expect(BaseRouterV2.gasConstants.swapJettonToTon.gasAmount,
            BigInt.parse('300000000'));

        expect(BaseRouterV2.gasConstants.swapTonToJetton.forwardGasAmount,
            BigInt.parse('300000000'));
      });
    });

    group('create', () {
      test('should create an instance of BaseRouterV2 from address', () {
        final contract = BaseRouterV2(
            address: BaseRouterV2(address: ROUTER_ADDRESS).address);

        expect(contract, isInstanceOf<BaseRouterV2>());
      });
    });

    group('createSwapBody', () {
      final userWalletAddress = address(USER_WALLET_ADDRESS);
      final refundAddress = userWalletAddress;
      final receiverAddress = userWalletAddress;
      final minAskAmount = BigInt.parse("900000000");
      final askJettonWalletAddress = InternalAddress.parse(ASK_JETTON_ADDRESS);

      test('should build expected tx body', () {
        final contract = BaseRouterV2(address: ROUTER_ADDRESS);
        final body = contract.createSwapBody(
            receiverAddress: receiverAddress,
            refundAddress: refundAddress,
            minAskAmount: minAskAmount,
            askJettonWalletAddress: askJettonWalletAddress);
        expect(base64.encode(body.toBoc()),
            "te6cckEBAgEAmAAB0SWThWGAD+mcSkD3Vv8TNqd5ZpGULbUWJKyGfGAnZzcSNZdG5HnQAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmiAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QAEAU0NaTpAIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzQAAAFEEo68v0=");
      });

      test("should build expected tx body when referralAddress is defined", () {
        final contract = BaseRouterV2(address: ROUTER_ADDRESS);

        final body = contract.createSwapBody(
          receiverAddress: receiverAddress,
          refundAddress: refundAddress,
          minAskAmount: minAskAmount,
          askJettonWalletAddress: askJettonWalletAddress,
          referralAddress: userWalletAddress,
        );
        expect(base64.encode(body.toBoc()),
            "te6cckEBAgEAuQAB0SWThWGAD+mcSkD3Vv8TNqd5ZpGULbUWJKyGfGAnZzcSNZdG5HnQAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmiAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QAEAlUNaTpAIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzQAAAFQAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmiFTdty8=");
      });

      test("should throw error if referralValue not in range", () {
        final contract = BaseRouterV2(address: ROUTER_ADDRESS);

        expect(() {
          contract.createSwapBody(
            receiverAddress: receiverAddress,
            refundAddress: refundAddress,
            minAskAmount: minAskAmount,
            askJettonWalletAddress: askJettonWalletAddress,
            referralAddress: userWalletAddress,
            referralValue: BigInt.from(200),
          );
        }, throwsException);

        expect(() {
          contract.createSwapBody(
            receiverAddress: receiverAddress,
            refundAddress: refundAddress,
            minAskAmount: minAskAmount,
            askJettonWalletAddress: askJettonWalletAddress,
            referralAddress: userWalletAddress,
            referralValue: BigInt.from(-1),
          );
        }, throwsException);
      });
    });

    group('createCrossSwapBody', () {
      final userWalletAddress = address(USER_WALLET_ADDRESS);
      final refundAddress = userWalletAddress;
      final receiverAddress = userWalletAddress;
      final minAskAmount = BigInt.parse("900000000");
      final askJettonWalletAddress = InternalAddress.parse(ASK_JETTON_ADDRESS);

      test('should build expected tx body', () {
        final contract = BaseRouterV2(address: ROUTER_ADDRESS);
        final body = contract.createCrossSwapBody(
            receiverAddress: receiverAddress,
            refundAddress: refundAddress,
            minAskAmount: minAskAmount,
            askJettonWalletAddress: askJettonWalletAddress);
        expect(base64.encode(body.toBoc()),
            "te6cckEBAgEAmAAB0f///++AD+mcSkD3Vv8TNqd5ZpGULbUWJKyGfGAnZzcSNZdG5HnQAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmiAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QAEAU0NaTpAIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzQAAAFED3fYVo=");
      });

      test("should build expected tx body when referralAddress is defined", () {
        final contract = BaseRouterV2(address: ROUTER_ADDRESS);

        final body = contract.createCrossSwapBody(
          receiverAddress: receiverAddress,
          refundAddress: refundAddress,
          minAskAmount: minAskAmount,
          askJettonWalletAddress: askJettonWalletAddress,
          referralAddress: userWalletAddress,
        );
        expect(base64.encode(body.toBoc()),
            "te6cckEBAgEAuQAB0f///++AD+mcSkD3Vv8TNqd5ZpGULbUWJKyGfGAnZzcSNZdG5HnQAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmiAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QAEAlUNaTpAIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzQAAAFQAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmiKqdgo8=");
      });

      test("should throw error if referralValue not in range", () {
        final contract = BaseRouterV2(address: ROUTER_ADDRESS);

        expect(() {
          contract.createCrossSwapBody(
            receiverAddress: receiverAddress,
            refundAddress: refundAddress,
            minAskAmount: minAskAmount,
            askJettonWalletAddress: askJettonWalletAddress,
            referralAddress: userWalletAddress,
            referralValue: BigInt.from(200),
          );
        }, throwsException);

        expect(() {
          contract.createCrossSwapBody(
            receiverAddress: receiverAddress,
            refundAddress: refundAddress,
            minAskAmount: minAskAmount,
            askJettonWalletAddress: askJettonWalletAddress,
            referralAddress: userWalletAddress,
            referralValue: BigInt.from(-1),
          );
        }, throwsException);
      });
    });

    group('getSwapJettonToJettonTxParams', () {
      final userWalletAddress = InternalAddress.parse(USER_WALLET_ADDRESS);
      final askJettonAddress = InternalAddress.parse(ASK_JETTON_ADDRESS);
      final offerJettonAddress = InternalAddress.parse(OFFER_JETTON_ADDRESS);
      final minAskAmount = BigInt.parse("200000000");
      final offerAmount = BigInt.parse("500000000");

      final client = FakeContractProviderGetter(
        (addr, methodName, args) {
          final stack = TupleBuilder();
          if (methodName == 'get_wallet_address') {
            if (addr.equals(address(OFFER_JETTON_ADDRESS))) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOACD+9EGh6wT/2pEbZWrfCmVbsdpQVGU9308qh2gel9QwQM97q5A==")
                  .beginParse());
            } else if (addr.equals(address(ASK_JETTON_ADDRESS))) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOAAQDOYNkjxevc0Ludmj5oWQzsz/S9vn9/b/V0DLdsOUWw40LsPA==")
                  .beginParse());
            }
          }

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test('should build expected tx params', () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapJettonToJettonTxParams(
          userWalletAddress: userWalletAddress,
          offerJettonAddress: offerJettonAddress,
          askJettonAddress: askJettonAddress,
          offerAmount: offerAmount,
          minAskAmount: minAskAmount,
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(
            txParams.body?.toBoc().toBase64(),
            equals(
                "te6cckEBAwEA8wABsA+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBycOAEBAdElk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAFNAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABRAUtuiX"));
        expect(txParams.value, equals(BigInt.from(300000000)));
      });

      test('should build expected tx params when referralAddress is defined',
          () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapJettonToJettonTxParams(
          userWalletAddress: userWalletAddress,
          offerJettonAddress: offerJettonAddress,
          askJettonAddress: askJettonAddress,
          offerAmount: offerAmount,
          minAskAmount: minAskAmount,
          referralAddress: userWalletAddress,
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(base64.encode(txParams.body!.toBoc()),
            'te6cckECAwEAARQAAbAPin6lAAAAAAAAAABB3NZQCAE1ZtT7v6IlkuZ+DmKTm4Q9uMHylpa3GSHH0ICrP8kfYQAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmggcnDgBAQHRJZOFYYABAM5g2SPF69zQu52aPmhZDOzP9L2+f39v9XQMt2w5RbAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRAAgCVQL68IAgAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNAAAAVAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaIIYL3Ww==');
        expect(txParams.value, BigInt.parse('300000000'));
      });

      test('should build expected tx params when queryId is defined', () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapJettonToJettonTxParams(
          userWalletAddress: userWalletAddress,
          offerJettonAddress: offerJettonAddress,
          askJettonAddress: askJettonAddress,
          offerAmount: offerAmount,
          minAskAmount: minAskAmount,
          queryId: BigInt.from(12345),
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(base64.encode(txParams.body!.toBoc()),
            'te6cckEBAwEA8wABsA+KfqUAAAAAAAAwOUHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBycOAEBAdElk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAFNAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABRCIhhxc');
        expect(txParams.value, BigInt.parse('300000000'));
      });

      test('should build expected tx params when custom gasAmount is defined',
          () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapJettonToJettonTxParams(
          userWalletAddress: userWalletAddress,
          offerJettonAddress: offerJettonAddress,
          askJettonAddress: askJettonAddress,
          offerAmount: offerAmount,
          minAskAmount: minAskAmount,
          gasAmount: BigInt.one,
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(base64.encode(txParams.body!.toBoc()),
            'te6cckEBAwEA8wABsA+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBycOAEBAdElk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAFNAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABRAUtuiX');
        expect(txParams.value, BigInt.one);
      });

      test(
          'should build expected tx params when custom forwardGasAmount is defined',
          () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapJettonToJettonTxParams(
          userWalletAddress: userWalletAddress,
          offerJettonAddress: offerJettonAddress,
          askJettonAddress: askJettonAddress,
          offerAmount: offerAmount,
          minAskAmount: minAskAmount,
          forwardGasAmount: BigInt.one,
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(base64.encode(txParams.body!.toBoc()),
            'te6cckEBAwEA8AABqg+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaAgMBAdElk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAFNAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABRCW13Q2');
        expect(txParams.value, BigInt.parse('300000000'));
      });
    });

    group('getSwapJettonToTonTxParams', () {
      final userWalletAddress = InternalAddress.parse(USER_WALLET_ADDRESS);
      final offerJettonAddress = InternalAddress.parse(OFFER_JETTON_ADDRESS);
      final minAskAmount = BigInt.parse("200000000");
      final offerAmount = BigInt.parse("500000000");
      final proxyTon = PTON_CONTRACT;

      final client = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          if (methodName == 'get_wallet_address') {
            if (address.equals(offerJettonAddress)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOACD+9EGh6wT/2pEbZWrfCmVbsdpQVGU9308qh2gel9QwQM97q5A==")
                  .beginParse());
            } else if (address.equals(proxyTon.address)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOAAioWoxZMTVqjEz8xEP8QSW4AyorIq+/8UCfgJNM0gMPwJB4oTQ==")
                  .beginParse());
            }
          }

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test('should build expected tx params', () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapJettonToTonTxParams(
          proxyTon: proxyTon,
          userWalletAddress: userWalletAddress,
          offerJettonAddress: offerJettonAddress,
          offerAmount: offerAmount,
          minAskAmount: minAskAmount,
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(base64.encode(txParams.body!.toBoc()),
            'te6cckEBAwEA8wABsA+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBycOAEBAdElk4VhgAIqFqMWTE1aoxM/MRD/EEluAMqKyKvv/FAn4CTTNIDD8ABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAFNAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABRCu+7I2');
        expect(txParams.value, BigInt.parse('300000000'));
      });

      test('should build expected tx params when referralAddress is defined',
          () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapJettonToTonTxParams(
            proxyTon: proxyTon,
            userWalletAddress: userWalletAddress,
            offerJettonAddress: offerJettonAddress,
            offerAmount: offerAmount,
            minAskAmount: minAskAmount,
            referralAddress: userWalletAddress);
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(base64.encode(txParams.body!.toBoc()),
            'te6cckECAwEAARQAAbAPin6lAAAAAAAAAABB3NZQCAE1ZtT7v6IlkuZ+DmKTm4Q9uMHylpa3GSHH0ICrP8kfYQAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmggcnDgBAQHRJZOFYYACKhajFkxNWqMTPzEQ/xBJbgDKisir7/xQJ+Ak0zSAw/AAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRAAgCVQL68IAgAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNAAAAVAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaILksOvw==');
        expect(txParams.value, BigInt.parse('300000000'));
      });

      test('should build expected tx params when queryId is defined', () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapJettonToTonTxParams(
            proxyTon: proxyTon,
            userWalletAddress: userWalletAddress,
            offerJettonAddress: offerJettonAddress,
            offerAmount: offerAmount,
            minAskAmount: minAskAmount,
            queryId: BigInt.from(12345));
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(base64.encode(txParams.body!.toBoc()),
            'te6cckEBAwEA8wABsA+KfqUAAAAAAAAwOUHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBycOAEBAdElk4VhgAIqFqMWTE1aoxM/MRD/EEluAMqKyKvv/FAn4CTTNIDD8ABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAFNAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABRAyy0b9');
        expect(txParams.value, BigInt.parse('300000000'));
      });

      test('should build expected tx params when custom gasAmount is defined',
          () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapJettonToTonTxParams(
          proxyTon: proxyTon,
          userWalletAddress: userWalletAddress,
          offerJettonAddress: offerJettonAddress,
          offerAmount: offerAmount,
          minAskAmount: minAskAmount,
          gasAmount: BigInt.one,
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(
          base64.encode(txParams.body!.toBoc()),
          "te6cckEBAwEA8wABsA+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBycOAEBAdElk4VhgAIqFqMWTE1aoxM/MRD/EEluAMqKyKvv/FAn4CTTNIDD8ABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAFNAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABRCu+7I2",
        );
        expect(txParams.value, BigInt.one);
      });

      test(
          'should build expected tx params when custom forwardGasAmount is defined',
          () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapJettonToTonTxParams(
          proxyTon: proxyTon,
          userWalletAddress: userWalletAddress,
          offerJettonAddress: offerJettonAddress,
          offerAmount: offerAmount,
          minAskAmount: minAskAmount,
          forwardGasAmount: BigInt.one,
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(
          base64.encode(txParams.body!.toBoc()),
          "te6cckEBAwEA8AABqg+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaAgMBAdElk4VhgAIqFqMWTE1aoxM/MRD/EEluAMqKyKvv/FAn4CTTNIDD8ABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAFNAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABRAsmi6X",
        );
        expect(txParams.value, BigInt.parse('300000000'));
      });
    });

    group('getSwapTonToJettonTxParams', () {
      final userWalletAddress = InternalAddress.parse(USER_WALLET_ADDRESS);
      final askJettonAddress = InternalAddress.parse(ASK_JETTON_ADDRESS);
      final minAskAmount = BigInt.parse("200000000");
      final offerAmount = BigInt.parse("500000000");

      final client = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          print('here asf');
          print(PTON_CONTRACT.address);
          print(askJettonAddress);
          print(address);
          if (methodName == 'get_wallet_address') {
            if (address.equals(askJettonAddress)) {
              print('here asf 1');
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOAAQDOYNkjxevc0Ludmj5oWQzsz/S9vn9/b/V0DLdsOUWw40LsPA==")
                  .beginParse());
            } else if (address.equals(PTON_CONTRACT.address)) {
              print('here asf 2');
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOAAioWoxZMTVqjEz8xEP8QSW4AyorIq+/8UCfgJNM0gMPwJB4oTQ==")
                  .beginParse());
            } else {
              print('here asf 3');
              print('wtf');
              throw Exception('Unexpected ${address.toString()}');
            }
          } else {
            print('here asf 5');
            print('wtf2');
            throw Exception('Unexpected $address');
          }

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      final proxyTon = client.open<PtonV1>(PTON_CONTRACT);

      test('should build expected tx params', () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapTonToJettonTxParams(
          proxyTon: proxyTon,
          askJettonAddress: askJettonAddress,
          userWalletAddress: userWalletAddress,
          offerAmount: offerAmount,
          minAskAmount: minAskAmount,
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQARULUYsmJq1RiZ-YiH-IJLcAZUVkVff-KBPwEmmaQGH6aC")),
            true);
        expect(base64.encode(txParams.body!.toBoc()),
            'te6cckEBAwEA0gABbQ+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9gEEeGjAMBAdElk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAFNAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABRCBvyRh');
        expect(txParams.value, BigInt.parse('800000000'));
      });

      test('should build expected tx params when referralAddress is defined',
          () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapTonToJettonTxParams(
            proxyTon: proxyTon,
            askJettonAddress: askJettonAddress,
            userWalletAddress: userWalletAddress,
            offerAmount: offerAmount,
            minAskAmount: minAskAmount,
            referralAddress: userWalletAddress);
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQARULUYsmJq1RiZ-YiH-IJLcAZUVkVff-KBPwEmmaQGH6aC")),
            true);
        expect(base64.encode(txParams.body!.toBoc()),
            'te6cckEBAwEA8wABbQ+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9gEEeGjAMBAdElk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAJVAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABUABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ohhq/lA');
        expect(txParams.value, BigInt.parse('800000000'));
      });

      test('should build expected tx params when queryId is defined', () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapTonToJettonTxParams(
            proxyTon: proxyTon,
            askJettonAddress: askJettonAddress,
            userWalletAddress: userWalletAddress,
            offerAmount: offerAmount,
            minAskAmount: minAskAmount,
            queryId: BigInt.from(12345));
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQARULUYsmJq1RiZ-YiH-IJLcAZUVkVff-KBPwEmmaQGH6aC")),
            true);
        expect(base64.encode(txParams.body!.toBoc()),
            'te6cckEBAwEA0gABbQ+KfqUAAAAAAAAwOUHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9gEEeGjAMBAdElk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAFNAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABRDeQKI6');
        expect(txParams.value, BigInt.parse('800000000'));
      });

      test(
          'should build expected tx params when custom forwardGasAmount is defined',
          () async {
        final contract =
            client.open<BaseRouterV2>(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getSwapTonToJettonTxParams(
          proxyTon: proxyTon,
          askJettonAddress: askJettonAddress,
          userWalletAddress: userWalletAddress,
          offerAmount: offerAmount,
          minAskAmount: minAskAmount,
          forwardGasAmount: BigInt.one,
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQARULUYsmJq1RiZ-YiH-IJLcAZUVkVff-KBPwEmmaQGH6aC")),
            true);
        expect(base64.encode(txParams.body!.toBoc()),
            'te6cckEBAwEAzwABZw+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9gBAcBAdElk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAFNAvrwgCAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AAABRCrRggS');
        expect(txParams.value, BigInt.parse('500000001'));
      });
    });

    group('createProvideLiquidityBody', () {
      final routerWalletAddress = InternalAddress.parse(
          "EQAIBnMGyR4vXuaF3OzR80LIZ2Z_pe3z-_t_q6Blu2HKLeaY");
      final receiverAddress = address(USER_WALLET_ADDRESS);
      final refundAddress = address(USER_WALLET_ADDRESS);
      const bothPositive = true;
      final minLpOut = BigInt.parse("900000000");

      test('should build expected tx body', () {
        final contract = BaseRouterV2(address: ROUTER_ADDRESS);
        final body = contract.createProvideLiquidityBody(
          refundAddress: refundAddress,
          receiverAddress: receiverAddress,
          bothPositive: bothPositive,
          routerWalletAddress: routerWalletAddress,
          minLpOut: minLpOut,
        );
        expect(
            base64.encode(body.toBoc()),
            equals(
                "te6cckEBAgEAlQAB0fz55Y+AAQDOYNkjxevc0Ludmj5oWQzsz/S9vn9/b/V0DLdsOUWwAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmiAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QAEATUNaTpAIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRBOPMRyY="));
      });
    });

    group('createCrossProvideLiquidityBody', () {
      final routerWalletAddress = InternalAddress.parse(
          "EQAIBnMGyR4vXuaF3OzR80LIZ2Z_pe3z-_t_q6Blu2HKLeaY");
      final receiverAddress = address(USER_WALLET_ADDRESS);
      final refundAddress = address(USER_WALLET_ADDRESS);
      const bothPositive = true;
      final minLpOut = BigInt.parse("900000000");

      test('should build expected tx body', () {
        final contract = BaseRouterV2(address: ROUTER_ADDRESS);
        final body = contract.createCrossProvideLiquidityBody(
          refundAddress: refundAddress,
          receiverAddress: receiverAddress,
          bothPositive: bothPositive,
          routerWalletAddress: routerWalletAddress,
          minLpOut: minLpOut,
        );
        expect(
            base64.encode(body.toBoc()),
            equals(
                "te6cckEBAgEAlQAB0f///v+AAQDOYNkjxevc0Ludmj5oWQzsz/S9vn9/b/V0DLdsOUWwAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmiAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QAEATUNaTpAIACE+JdUq+wPWHEaGeeZ6wHj2SzKrIOfTGgf/k9ACJZzRBP2Nz5Y="));
      });
    });

    group('getProvideLiquidityJettonTxParams', () {
      final userWalletAddress = InternalAddress.parse(USER_WALLET_ADDRESS);
      final sendTokenAddress = InternalAddress.parse(OFFER_JETTON_ADDRESS);
      final otherTokenAddress = InternalAddress.parse(ASK_JETTON_ADDRESS);
      final sendAmount = BigInt.parse("500000000");
      final minLpOut = BigInt.one;

      final client = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          if (methodName == 'get_wallet_address') {
            if (address.equals(sendTokenAddress)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOACD+9EGh6wT/2pEbZWrfCmVbsdpQVGU9308qh2gel9QwQM97q5A==")
                  .beginParse());
            } else if (address.equals(otherTokenAddress)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOAAQDOYNkjxevc0Ludmj5oWQzsz/S9vn9/b/V0DLdsOUWw40LsPA==")
                  .beginParse());
            }
          }

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test('should build expected tx params', () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getProvideLiquidityJettonTxParams(
            userWalletAddress: userWalletAddress,
            sendTokenAddress: sendTokenAddress,
            otherTokenAddress: otherTokenAddress,
            sendAmount: sendAmount,
            minLpOut: minLpOut);
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(
            base64.encode(txParams.body!.toBoc()),
            equals(
                "te6cckEBAwEA7QABsA+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBwDoYEBAdH8+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAEcQGAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QSd6si5"));
        expect(txParams.value, equals(BigInt.parse("300000000")));
      });

      test('should build expected tx params when queryId is defined', () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getProvideLiquidityJettonTxParams(
          userWalletAddress: userWalletAddress,
          sendTokenAddress: sendTokenAddress,
          otherTokenAddress: otherTokenAddress,
          sendAmount: sendAmount,
          minLpOut: minLpOut,
          queryId: BigInt.from(12345),
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(
            base64.encode(txParams.body!.toBoc()),
            equals(
                "te6cckEBAwEA7QABsA+KfqUAAAAAAAAwOUHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBwDoYEBAdH8+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAEcQGAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QTIC8jO"));
        expect(txParams.value, equals(BigInt.parse("300000000")));
      });

      test('should build expected tx params when custom gasAmount is defined',
          () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getProvideLiquidityJettonTxParams(
            userWalletAddress: userWalletAddress,
            sendTokenAddress: sendTokenAddress,
            otherTokenAddress: otherTokenAddress,
            sendAmount: sendAmount,
            minLpOut: minLpOut,
            gasAmount: BigInt.one,
            forwardGasAmount: BigInt.two);
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            true);
        expect(
            base64.encode(txParams.body!.toBoc()),
            equals(
                "te6cckEBAwEA6gABqg+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaAgUBAdH8+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAEcQGAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QRCcylQ"));
        expect(txParams.value, equals(BigInt.one));
      });
    });

    group('getProvideLiquidityTonTxParams', () {
      final userWalletAddress = InternalAddress.parse(USER_WALLET_ADDRESS);
      final otherTokenAddress = InternalAddress.parse(ASK_JETTON_ADDRESS);
      final sendAmount = BigInt.parse("500000000");
      final minLpOut = BigInt.one;

      final client = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          if (methodName == 'get_wallet_address') {
            if (address.equals(PTON_CONTRACT.address)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOAAioWoxZMTVqjEz8xEP8QSW4AyorIq+/8UCfgJNM0gMPwJB4oTQ==")
                  .beginParse());
            } else if (address.equals(otherTokenAddress)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOAAQDOYNkjxevc0Ludmj5oWQzsz/S9vn9/b/V0DLdsOUWw40LsPA==")
                  .beginParse());
            }
          }

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      final proxyTon = client.open(PTON_CONTRACT);

      test('should build expected tx params', () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getProvideLiquidityTonTxParams(
            userWalletAddress: userWalletAddress,
            otherTokenAddress: otherTokenAddress,
            sendAmount: sendAmount,
            minLpOut: minLpOut,
            proxyTon: proxyTon);
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQARULUYsmJq1RiZ-YiH-IJLcAZUVkVff-KBPwEmmaQGH6aC")),
            equals(true));
        expect(
            base64.encode(txParams.body!.toBoc()),
            equals(
                "te6cckEBAwEAzAABbQ+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9gEEeGjAMBAdH8+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAEcQGAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QSjBt/5"));
        expect(txParams.value, equals(BigInt.parse("800000000")));
      });

      test('should build expected tx params when queryId is defined', () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getProvideLiquidityTonTxParams(
          proxyTon: proxyTon,
          userWalletAddress: userWalletAddress,
          otherTokenAddress: otherTokenAddress,
          sendAmount: sendAmount,
          minLpOut: minLpOut,
          queryId: BigInt.from(12345),
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQARULUYsmJq1RiZ-YiH-IJLcAZUVkVff-KBPwEmmaQGH6aC")),
            equals(true));
        expect(
            base64.encode(txParams.body!.toBoc()),
            equals(
                "te6cckEBAwEAzAABbQ+KfqUAAAAAAAAwOUHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9gEEeGjAMBAdH8+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAEcQGAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QQFvZ1C"));
        expect(txParams.value, equals(BigInt.parse("800000000")));
      });

      test('should build expected tx params when custom gasAmount is defined',
          () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams = await contract.getProvideLiquidityTonTxParams(
            proxyTon: proxyTon,
            userWalletAddress: userWalletAddress,
            otherTokenAddress: otherTokenAddress,
            sendAmount: sendAmount,
            minLpOut: minLpOut,
            forwardGasAmount: BigInt.two);
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQARULUYsmJq1RiZ-YiH-IJLcAZUVkVff-KBPwEmmaQGH6aC")),
            equals(true));
        expect(
            base64.encode(txParams.body!.toBoc()),
            equals(
                "te6cckEBAwEAyQABZw+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9gBAsBAdH8+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAEcQGAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0QRKTjrp"));
        expect(txParams.value, equals(BigInt.parse("500000002")));
      });
    });

    group('getSingleSideProvideLiquidityJettonTxParams', () {
      final userWalletAddress = InternalAddress.parse(USER_WALLET_ADDRESS);
      final sendTokenAddress = InternalAddress.parse(OFFER_JETTON_ADDRESS);
      final otherTokenAddress = InternalAddress.parse(ASK_JETTON_ADDRESS);
      final sendAmount = BigInt.parse("500000000");
      final minLpOut = BigInt.one;

      final client = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          if (methodName == 'get_wallet_address') {
            if (address.equals(sendTokenAddress)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOACD+9EGh6wT/2pEbZWrfCmVbsdpQVGU9308qh2gel9QwQM97q5A==")
                  .beginParse());
            } else if (address.equals(otherTokenAddress)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOAAQDOYNkjxevc0Ludmj5oWQzsz/S9vn9/b/V0DLdsOUWw40LsPA==")
                  .beginParse());
            }
          }

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test('should build expected tx params', () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams =
            await contract.getSingleSideProvideLiquidityJettonTxParams(
                userWalletAddress: userWalletAddress,
                otherTokenAddress: otherTokenAddress,
                sendAmount: sendAmount,
                minLpOut: minLpOut,
                sendTokenAddress: sendTokenAddress);
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            equals(true));
        expect(
            base64.encode(txParams.body!.toBoc()),
            equals(
                "te6cckEBAwEA7QABsA+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCF9eEAEBAdH8+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAEcQGAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0ATdcreC"));
        expect(txParams.value, equals(BigInt.parse("1000000000")));
      });

      test('should build expected tx params when queryId is defined', () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams =
            await contract.getSingleSideProvideLiquidityJettonTxParams(
          sendTokenAddress: sendTokenAddress,
          userWalletAddress: userWalletAddress,
          otherTokenAddress: otherTokenAddress,
          sendAmount: sendAmount,
          minLpOut: minLpOut,
          queryId: BigInt.from(12345),
        );
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            equals(true));
        expect(
            base64.encode(txParams.body!.toBoc()),
            equals(
                "te6cckEBAwEA7QABsA+KfqUAAAAAAAAwOUHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCF9eEAEBAdH8+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAEcQGAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0ASIk7f1"));
        expect(txParams.value, equals(BigInt.parse("1000000000")));
      });

      test('should build expected tx params when custom gasAmount is defined',
          () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final txParams =
            await contract.getSingleSideProvideLiquidityJettonTxParams(
                sendTokenAddress: sendTokenAddress,
                userWalletAddress: userWalletAddress,
                otherTokenAddress: otherTokenAddress,
                sendAmount: sendAmount,
                minLpOut: minLpOut,
                gasAmount: BigInt.one,
                forwardGasAmount: BigInt.two);
        expect(
            txParams.to.equals(InternalAddress.parse(
                "EQBB_eiDQ9YJ_7UiNsrVvhTKt2O0oKjKe76eVQ7QPS-oYPsi")),
            equals(true));
        expect(
            base64.encode(txParams.body!.toBoc()),
            equals(
                "te6cckEBAwEA6gABqg+KfqUAAAAAAAAAAEHc1lAIATVm1Pu/oiWS5n4OYpObhD24wfKWlrcZIcfQgKs/yR9hAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaAgUBAdH8+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFsABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5ogAIT4l1Sr7A9YcRoZ55nrAePZLMqsg59MaB/+T0AIlnNEACAEcQGAAhPiXVKvsD1hxGhnnmesB49ksyqyDn0xoH/5PQAiWc0AQ164tD"));
        expect(txParams.value, equals(BigInt.one));
      });
    });

    group('getPoolAddress', () {
      final client = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeSlice(Cell.fromBocBase64(
                  "te6ccsEBAQEAJAAAAEOAFL81j9ygFp1c3p71Zs3Um3CwytFAzr8LITNsQqQYk1nQDFEwYA==")
              .beginParse());

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );
      test('should make on-chain request and return parsed response', () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final poolAddress = await contract.getPoolAddress(
            token0: InternalAddress.parse(
                "0:87b92241aa6a57df31271460c109c54dfd989a1aea032f6107d2c65d6e8879ce"),
            token1: InternalAddress.parse(
                "0:9f557c3e09518b8a73bccfef561896832a35b220e85df1f66834b2170db0dfcb"));
        expect(
            poolAddress.equals(
                address("EQCl-ax-5QC06ub096s2bqTbhYZWigZ1-FkJm2IVIMSazp7U")),
            equals(true));
      });
    });

    group("getPoolAddress", () {
      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeSlice(Cell.fromBocBase64(
                  "te6cckEBAQEAJAAAQ4AcWjZMMl4PnV4hXc0bTXOnmOCQPE08nma5bszegFth3FBjJd6+")
              .beginParse());

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test("should make on-chain request and return parsed response", () async {
        final contract = provider.open(BaseRouterV2(address: ROUTER_ADDRESS));

        final poolAddress = await contract.getPoolAddress(
          token0: address("EQBqMJD7AXc2Wtt9NHg4kzMbJi2JwS_Hk6kCtLsw2c2CPyVU"),
          // Wallet of ASK_JETTON_ADDRESS with USER_WALLET_ADDRESS owner
          token1: address(
              "EQAvBlP_FK6SQQRtkoLsO8U-Ycvmdxrrdopx_xxaTumvs26X"), // Wallet of OFFER_JETTON_ADDRESS with USER_WALLET_ADDRESS owner
        );

        expect(
            poolAddress.equals(
                address("EQDi0bJhkvB86vEK7mjaa508xwSB4mnk8zXLdmb0AtsO4iG7")),
            equals(true));
      });
    });

    group('getPool', () {
      test('should return Pool instance for existing pair', () async {
        final client = FakeContractProviderGetter(
          (address, methodName, args) {
            final stack = TupleBuilder();
            if (address.equals(ROUTER_ADDRESS) &&
                methodName == 'get_pool_address') {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6cckEBAQEAJAAAQ4AcWjZMMl4PnV4hXc0bTXOnmOCQPE08nma5bszegFth3FBjJd6+")
                  .beginParse());
            } else if (address
                    .equals(InternalAddress.parse(OFFER_JETTON_ADDRESS)) &&
                methodName == 'get_wallet_address') {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6cckEBAQEAJAAAQ4ATmaZ7TLWAsPlzzyZBHUychwiCFGUXrTsOROB1sQcwtxDOko/O")
                  .beginParse());
            } else if (address
                    .equals(InternalAddress.parse(ASK_JETTON_ADDRESS)) &&
                methodName == 'get_wallet_address') {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6cckEBAQEAJAAAQ4AFImSaUo+dFf1OYl8dtYp9Zj6M0s4JKV4Dgg9WfZm54vCRWjIN")
                  .beginParse());
            }

            return Future.value(ContractGetMethodResult(
              stack: TupleReader(stack.build()),
            ));
          },
        );

        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final pool = await contract.getPool(
          token0: InternalAddress.parse(OFFER_JETTON_ADDRESS),
          token1: InternalAddress.parse(ASK_JETTON_ADDRESS),
        );
        expect(pool, isInstanceOf<PoolV2>());
      });
    });

    group("getVaultAddress", () {
      final provider = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeSlice(Cell.fromBocBase64(
                  "te6cckEBAQEAJAAAQ4AZABzFeODYBGs2+ChMt5KqNDN2J36bMzV5qsfyYIb2hdBmJxuo")
              .beginParse());

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test("should make on-chain request and return parsed response", () async {
        final contract = provider.open(BaseRouterV2(address: ROUTER_ADDRESS));

        final poolAddress = await contract.getVaultAddress(
            user: address(USER_WALLET_ADDRESS),
            tokenWallet: address(OFFER_JETTON_ADDRESS));

        expect(
            poolAddress.equals(
                address("EQDIAOYrxwbAI1m3wUJlvJVRoZuxO_TZmavNVj-TBDe0LiLR")),
            equals(true));
      });
    });

    group('getVault', () {
      test('should return Pool instance for existing pair', () async {
        final client = FakeContractProviderGetter(
          (address, methodName, args) {
            final stack = TupleBuilder();
            stack.writeSlice(
                Cell.fromBocBase64("te6cckEBAQEAJAAAQ4ATmaZ7TLWAsPlzzyZBHUychwiCFGUXrTsOROB1sQcwtxDOko/O").beginParse());

            return Future.value(ContractGetMethodResult(
              stack: TupleReader(stack.build()),
            ));
          },
        );

        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final vault = await contract.getVault(
          user: address(OFFER_JETTON_ADDRESS),
          tokenWallet: address(OFFER_JETTON_ADDRESS),
        );
        expect(vault, isInstanceOf<VaultV2>());
      });
    });

    group('getRouterVersion', () {
      final client = FakeContractProviderGetter(
            (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeInt(BigInt.two);
          stack.writeInt(BigInt.zero);
          stack.writeCell(
              Cell.fromBocBase64("te6cckEBAQEACQAADnJlbGVhc2VkOXx8"));

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test('should make on-chain request and return parsed response', () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final version = await contract.getRouterVersion();
        expect(version.major, equals(2));
        expect(version.minor, equals(0));
        expect(version.development, equals('release'));
      });
    });


    group('getRouterData', () {
      final client = FakeContractProviderGetter(
            (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeInt(BigInt.from(100));
          stack.writeCell(Cell.fromBocBase64(
              "te6cckEBAQEAEgAAIGNvbnN0YW50X3Byb2R1Y3Svg+BE"));
          stack.writeInt(BigInt.zero);
          stack.writeCell(Cell.fromBocBase64("te6cckEBAQEAJAAAQ4AVNOalswyRkG4pCMopecKdFTbQWmMc0eZ0+lHY/BngFzCuo2Mw"));
          stack.writeCell(Cell.fromBocBase64(
              "te6cckEBAgEAFgABIQAAAAAAAAAAAAAAAAAAAAAgAQAAnpyZMQ=="));
          stack.writeCell(Cell.fromBocBase64(
              "te6cckEBAgEALQABDv8AiNDtHtgBCEIChnQ3+jCz9g/PrBDgdaR6qm2P9KGSGpEez2qAlMZp3knh+w3/"));
          stack.writeCell(Cell.fromBocBase64(
              "te6cckEBAgEALQABDv8AiNDtHtgBCEIC5iL45BzAt4svg+TAdXsfYKBJ25AwN23oNwIKAZBBjrFI2HBV"));
          stack.writeCell(Cell.fromBocBase64(
              "te6cckEBAgEALQABDv8AiNDtHtgBCEIC5wowbAAnJ5YkP1ac4Mko6kz8nxtlxbAGbjghWfXoDfVdmtEr"));
          stack.writeCell(Cell.fromBocBase64(
              "te6cckEBAgEALQABDv8AiNDtHtgBCEIC9yl8isz61M/WMpoDa/zAHcbJqrSfLJXC0j7Bcq1o/t4aA6m8"));

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test('should make on-chain request and return parsed response', () async {
        final contract = client.open(BaseRouterV2(address: ROUTER_ADDRESS));
        final data = await contract.getRouterData();
        expect(data.routerId, 100);
        expect(data.dexType, DexType.CPI);
        expect(data.isLocked, equals(false));
        expect(
            data.adminAddress.equals(
                address("EQCppzUtmGSMg3FIRlFLzhToqbaC0xjmjzOn0o7H4M8Aua1t")),
            equals(true));
        expect(base64.encode(data.tempUpgrade.toBoc()),
            equals("te6cckEBAgEAFgABIQAAAAAAAAAAAAAAAAAAAAAgAQAAnpyZMQ=="));
      });
    });
  });
}
