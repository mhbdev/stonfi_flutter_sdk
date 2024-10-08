import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:stonfi/contracts/dex/constants.dart';
import 'package:stonfi/contracts/dex/v1/pool_v1.dart';
import 'package:stonfi/contracts/dex/v1/router_v1.dart';
import 'package:stonfi/contracts/pTON/v1/pton_v1.dart';
import 'package:tonutils/dataformat.dart';

import '../../../mock_contract_provider.dart';

const OFFER_JETTON_ADDRESS =
    "EQA2kCVNwVsil2EM2mB0SkXytxCqQjS4mttjDpnXmwG9T6bO"; // STON
const ASK_JETTON_ADDRESS =
    "EQBX6K9aXVl3nXINCyPPL86C4ONVmQ8vK360u6dykFKXpHCa"; // GEMSTON
const USER_WALLET_ADDRESS = "UQAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D_8noARLOaEAn";

void main() {
  group('RouterV1', () {
    group('version', () {
      test('should have expected static value',
          () => expect(RouterV1.version, DexVersion.v1));
    });

    group('address', () {
      test('should have expected static value', () {
        expect(
            RouterV1().address.equals(InternalAddress.parse(
                'EQB3ncyBUTjZUA5EnFKR5_EnOMI9V1tTEAAPaiU71gc4TiUt')),
            true);
      });
    });

    group('gasConstants', () {
      test('should have expected static values', () {
        expect(RouterV1.gasConstants.provideLpJetton.forwardGasAmount,
            BigInt.parse('240000000'));

        expect(RouterV1.gasConstants.provideLpJetton.gasAmount,
            BigInt.parse('300000000'));

        expect(RouterV1.gasConstants.provideLpTon.forwardGasAmount,
            BigInt.parse('260000000'));

        expect(RouterV1.gasConstants.swapJettonToJetton.forwardGasAmount,
            BigInt.parse('175000000'));

        expect(RouterV1.gasConstants.swapJettonToJetton.gasAmount,
            BigInt.parse('220000000'));

        expect(RouterV1.gasConstants.swapJettonToTon.forwardGasAmount,
            BigInt.parse('125000000'));

        expect(RouterV1.gasConstants.swapJettonToTon.gasAmount,
            BigInt.parse('170000000'));

        expect(RouterV1.gasConstants.swapTonToJetton.forwardGasAmount,
            BigInt.parse('185000000'));
      });
    });

    group('create', () {
      test('should create an instance of RouterV1 from address', () {
        final contract = RouterV1(address: RouterV1().address);

        expect(contract, isInstanceOf<RouterV1>());
      });
    });

    group('createSwapBody', () {
      final userWalletAddress = InternalAddress.parse(USER_WALLET_ADDRESS);
      final minAskAmount = BigInt.parse("900000000");
      final askJettonWalletAddress = InternalAddress.parse(ASK_JETTON_ADDRESS);

      test('should build expected tx body', () {
        final contract = RouterV1();
        final body = contract.createSwapBody(
            userWalletAddress: userWalletAddress,
            minAskAmount: minAskAmount,
            askJettonWalletAddress: askJettonWalletAddress);
        expect(base64.encode(body.toBoc()),
            "te6cckEBAQEATgAAlyWThWGACv0V60urLvOuQaFkeeX50FwcarMh5eVv1pd07lIKUvSIa0nSAQAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmhCqzILs");
      });

      test("should build expected tx body when referralAddress is defined", () {
        final contract = RouterV1();

        final body = contract.createSwapBody(
          userWalletAddress: userWalletAddress,
          minAskAmount: minAskAmount,
          askJettonWalletAddress: askJettonWalletAddress,
          referralAddress: userWalletAddress,
        );
        expect(base64.encode(body.toBoc()),
            "te6cckEBAQEAbwAA2SWThWGACv0V60urLvOuQaFkeeX50FwcarMh5eVv1pd07lIKUvSIa0nSAQAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmjAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaKezq+h");
      });
    });

    group('getSwapJettonToJettonTxParams', () {
      final userWalletAddress = InternalAddress.parse(USER_WALLET_ADDRESS);
      final askJettonAddress = InternalAddress.parse(ASK_JETTON_ADDRESS);
      final offerJettonAddress = InternalAddress.parse(OFFER_JETTON_ADDRESS);
      final minAskAmount = BigInt.parse("200000000");
      final offerAmount = BigInt.parse("500000000");

      final client = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          // owner address
          final address =
              (args.first as TiSlice).cell.beginParse().loadInternalAddress();
          if (methodName == 'get_wallet_address') {
            if (address.equals(userWalletAddress)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOACD+9EGh6wT/2pEbZWrfCmVbsdpQVGU9308qh2gel9QwQM97q5A==")
                  .beginParse());
            } else if (address.equals(RouterV1().address)) {
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
        final contract = client.open<RouterV1>(RouterV1());
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
      });

      test('should build expected tx params when referralAddress is defined',
          () async {
        final contract = client.open<RouterV1>(RouterV1());
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
            'te6cckEBAgEAygABsA+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBTck4EBANklk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFqBfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5owAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmiwUoOyQ==');
        expect(txParams.value, BigInt.parse('220000000'));
      });

      test('should build expected tx params when queryId is defined', () async {
        final contract = client.open<RouterV1>(RouterV1());
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
            'te6cckEBAgEAqQABsA+KfqUAAAAAAAAwOUHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBTck4EBAJclk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFqBfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5oQ/ZI/NA==');
        expect(txParams.value, BigInt.parse('220000000'));
      });

      test('should build expected tx params when custom gasAmount is defined',
          () async {
        final contract = client.open<RouterV1>(RouterV1());
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
            'te6cckEBAgEAqQABsA+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBTck4EBAJclk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFqBfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5oQsE7cRQ==');
        expect(txParams.value, BigInt.one);
      });

      test(
          'should build expected tx params when custom forwardGasAmount is defined',
          () async {
        final contract = client.open<RouterV1>(RouterV1());
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
            'te6cckEBAgEApgABqg+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaAgMBAJclk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFqBfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5oQHS9BEQ==');
        expect(txParams.value, BigInt.parse('220000000'));
      });
    });

    group('getSwapJettonToTonTxParams', () {
      final userWalletAddress = InternalAddress.parse(USER_WALLET_ADDRESS);
      final offerJettonAddress = InternalAddress.parse(OFFER_JETTON_ADDRESS);
      final minAskAmount = BigInt.parse("200000000");
      final offerAmount = BigInt.parse("500000000");

      final client = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          // owner address
          final address =
              (args.first as TiSlice).cell.beginParse().loadInternalAddress();
          if (methodName == 'get_wallet_address') {
            if (address.equals(userWalletAddress)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOACD+9EGh6wT/2pEbZWrfCmVbsdpQVGU9308qh2gel9QwQM97q5A==")
                  .beginParse());
            } else if (address.equals(RouterV1().address)) {
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

      final proxyTon = client.open<PtonV1>(PtonV1());

      test('should build expected tx params', () async {
        final contract = client.open<RouterV1>(RouterV1());
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
            'te6cckEBAgEAqQABsA+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCA7msoEBAJclk4VhgAIqFqMWTE1aoxM/MRD/EEluAMqKyKvv/FAn4CTTNIDD6BfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5oQv9h8dw==');
        expect(txParams.value, BigInt.parse('170000000'));
      });

      test('should build expected tx params when referralAddress is defined',
          () async {
        final contract = client.open<RouterV1>(RouterV1());
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
            'te6cckEBAgEAygABsA+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCA7msoEBANklk4VhgAIqFqMWTE1aoxM/MRD/EEluAMqKyKvv/FAn4CTTNIDD6BfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5owAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmi8vLJFA==');
        expect(txParams.value, BigInt.parse('170000000'));
      });

      test('should build expected tx params when queryId is defined', () async {
        final contract = client.open<RouterV1>(RouterV1());
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
            'te6cckEBAgEAqQABsA+KfqUAAAAAAAAwOUHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCA7msoEBAJclk4VhgAIqFqMWTE1aoxM/MRD/EEluAMqKyKvv/FAn4CTTNIDD6BfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5oQ8gSfBg==');
        expect(txParams.value, BigInt.parse('170000000'));
      });

      test('should build expected tx params when custom gasAmount is defined',
          () async {
        final contract = client.open<RouterV1>(RouterV1());
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
          "te6cckEBAgEAqQABsA+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCA7msoEBAJclk4VhgAIqFqMWTE1aoxM/MRD/EEluAMqKyKvv/FAn4CTTNIDD6BfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5oQv9h8dw==",
        );
        expect(txParams.value, BigInt.one);
      });

      test(
          'should build expected tx params when custom forwardGasAmount is defined',
          () async {
        final contract = client.open<RouterV1>(RouterV1());
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
          "te6cckEBAgEApgABqg+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaAgMBAJclk4VhgAIqFqMWTE1aoxM/MRD/EEluAMqKyKvv/FAn4CTTNIDD6BfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5oQyZHaEA==",
        );
        expect(txParams.value, BigInt.parse('170000000'));
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
          if (methodName == 'get_wallet_address') {
            if (address.equals(askJettonAddress)) {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOAAQDOYNkjxevc0Ludmj5oWQzsz/S9vn9/b/V0DLdsOUWw40LsPA==")
                  .beginParse());
            } else if (address.equals(PtonV1.staticAddress)) {
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

      final proxyTon = client.open<PtonV1>(PtonV1());

      test('should build expected tx params', () async {
        final contract = client.open<RouterV1>(RouterV1());
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
            'te6cckEBAgEAiAABbQ+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCcECwbgQMBAJclk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFqBfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5oQ4VeW3A==');
        expect(txParams.value, BigInt.parse('685000000'));
      });

      test('should build expected tx params when referralAddress is defined',
          () async {
        final contract = client.open<RouterV1>(RouterV1());
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
            'te6cckEBAgEAqQABbQ+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCcECwbgQMBANklk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFqBfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5owAEJ8S6pV9gesOI0M88z1gPHslmVWQc+mNA//J6AESzmi/Fv4ew==');
        expect(txParams.value, BigInt.parse('685000000'));
      });

      test('should build expected tx params when queryId is defined', () async {
        final contract = client.open<RouterV1>(RouterV1());
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
            'te6cckEBAgEAiAABbQ+KfqUAAAAAAAAwOUHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCcECwbgQMBAJclk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFqBfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5oQq/XlXw==');
        expect(txParams.value, BigInt.parse('685000000'));
      });

      test(
          'should build expected tx params when custom forwardGasAmount is defined',
          () async {
        final contract = client.open<RouterV1>(RouterV1());
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
            'te6cckEBAgEAhQABZw+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCcBAcBAJclk4VhgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFqBfXhAEABCfEuqVfYHrDiNDPPM9YDx7JZlVkHPpjQP/yegBEs5oQoDsKGA==');
        expect(txParams.value, BigInt.parse('500000001'));
      });
    });

    group('createProvideLiquidityBody', () {
      final routerWalletAddress = InternalAddress.parse(
          "EQAIBnMGyR4vXuaF3OzR80LIZ2Z_pe3z-_t_q6Blu2HKLeaY");
      final minLpOut = BigInt.parse("900000000");

      test('should build expected tx body', () {
        final contract = RouterV1();
        final body = contract.createProvideLiquidityBody(
          routerWalletAddress: routerWalletAddress,
          minLpOut: minLpOut,
        );
        expect(
            base64.encode(body.toBoc()),
            equals(
                "te6cckEBAQEALAAAU/z55Y+AAQDOYNkjxevc0Ludmj5oWQzsz/S9vn9/b/V0DLdsOUWoa0nSAdDW3xU="));
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
        final contract = client.open(RouterV1());
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
                "te6cckEBAgEAhAABsA+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBycOAEBAE38+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFogMsmgJ2"));
        expect(txParams.value, equals(BigInt.parse("300000000")));
      });

      test('should build expected tx params when queryId is defined', () async {
        final contract = client.open(RouterV1());
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
                "te6cckEBAgEAhAABsA+KfqUAAAAAAAAwOUHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaCBycOAEBAE38+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFogOYpqed"));
        expect(txParams.value, equals(BigInt.parse("300000000")));
      });

      test('should build expected tx params when custom gasAmount is defined',
          () async {
        final contract = client.open(RouterV1());
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
                "te6cckEBAgEAgQABqg+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCdAAQnxLqlX2B6w4jQzzzPWA8eyWZVZBz6Y0D/8noARLOaAgUBAE38+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFogPlXGF2"));
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
            if (address.equals(PtonV1.staticAddress)) {
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

      final proxyTon = client.open(PtonV1());

      test('should build expected tx params', () async {
        final contract = client.open(RouterV1());
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
                "te6cckEBAgEAYwABbQ+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCcED39JAMBAE38+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFogPLyEMA"));
        expect(txParams.value, equals(BigInt.parse("760000000")));
      });

      test('should build expected tx params when queryId is defined', () async {
        final contract = client.open(RouterV1());
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
                "te6cckEBAgEAYwABbQ+KfqUAAAAAAAAwOUHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCcED39JAMBAE38+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFogOsHyfF"));
        expect(txParams.value, equals(BigInt.parse("760000000")));
      });

      test('should build expected tx params when custom gasAmount is defined',
          () async {
        final contract = client.open(RouterV1());
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
                "te6cckEBAgEAYAABZw+KfqUAAAAAAAAAAEHc1lAIAO87mQKicbKgHIk4pSPP4k5xhHqutqYgAB7USnesDnCcBAsBAE38+eWPgAEAzmDZI8Xr3NC7nZo+aFkM7M/0vb5/f2/1dAy3bDlFogMUO5pP"));
        expect(txParams.value, equals(BigInt.parse("500000002")));
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
        final contract = client.open(RouterV1());
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

    group('getPool', () {
      test('should return Pool instance for existing pair', () async {
        final client = FakeContractProviderGetter(
          (address, methodName, args) {
            final stack = TupleBuilder();
            if (address.equals(RouterV1().address) && methodName == 'get_pool_address') {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOABTuxjU0JqtDko8O1p92eNHHiuy6flx275gE6iecPgD8Q0X0lFw==")
                  .beginParse());
            } else if (address
                .equals(InternalAddress.parse(OFFER_JETTON_ADDRESS)) && methodName == 'get_wallet_address') {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOAFyFIKPdQf9SwP1GudjklnwW5klYY2/JJh4CqeuJ2a82QaHOF8w==")
                  .beginParse());
            } else if (address
                .equals(InternalAddress.parse(ASK_JETTON_ADDRESS)) && methodName == 'get_wallet_address') {
              stack.writeSlice(Cell.fromBocBase64(
                      "te6ccsEBAQEAJAAAAEOAAQDOYNkjxevc0Ludmj5oWQzsz/S9vn9/b/V0DLdsOUWw40LsPA==")
                  .beginParse());
            }

            return Future.value(ContractGetMethodResult(
              stack: TupleReader(stack.build()),
            ));
          },
        );

        final contract = client.open(RouterV1());
        final pool = await contract.getPool(
          token0: InternalAddress.parse(OFFER_JETTON_ADDRESS),
          token1: InternalAddress.parse(ASK_JETTON_ADDRESS),
        );
        expect(pool, isInstanceOf<PoolV1>());
      });
    });

    group('getRouterData', () {
      final client = FakeContractProviderGetter(
        (address, methodName, args) {
          final stack = TupleBuilder();
          stack.writeInt(BigInt.zero);
          stack.writeCell(Cell.fromBocBase64(
              "te6ccsEBAQEAJAAAAEOACTN3gl9yZ6lMTviWYFH4dL8SUXFIMHH8M+HgXr/0324Q2cH+VQ=="));
          stack.writeCell(Cell.fromBocBase64(
              "te6ccsEBAgEAFgAAFAEhAAAAAAAAAAAAAAAAAAAAACABAAAAkbB8"));
          stack.writeCell(Cell.fromBocBase64(
              "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"));
          stack.writeCell(Cell.fromBocBase64(
              "te6ccsECDwEAAxUAAAAADQASABcAdQB6AH8A/QFVAVoB2gIUAlQCwgMFART/APSkE/S88sgLAQIBYgIOAgLMAwQAt9kGOASS+CcADoaYGAuNhKia+B+AZwfSB9IBj9ABi465D9ABj9ABgBaY+QwQgHxT9S3UqYmiz4BPAQwQgLxqKM3UsYoiIB+AVwGsEILK+D3l1JrPgF8C+CQgf5eEAgEgBQ0CASAGCAH1UD0z/6APpAcCKAVQH6RDBYuvL07UTQ+gD6QPpA1DBRNqFSKscF8uLBKML/8uLCVDRCcFQgE1QUA8hQBPoCWM8WAc8WzMkiyMsBEvQA9ADLAMkg+QBwdMjLAsoHy//J0AT6QPQEMfoAINdJwgDy4sR3gBjIywVQCM8WcIBwCs+gIXy2sTzIIQF41FGcjLHxnLP1AH+gIizxZQBs8WJfoCUAPPFslQBcwjkXKRceJQCKgToIIJycOAoBS88uLFBMmAQPsAECPIUAT6AljPFgHPFszJ7VQCASAJDAL3O1E0PoA+kD6QNQwCNM/+gBRUaAF+kD6QFNbxwVUc21wVCATVBQDyFAE+gJYzxYBzxbMySLIywES9AD0AMsAyfkAcHTIywLKB8v/ydBQDccFHLHy4sMK+gBRqKGCCJiWgGa2CKGCCJiWgKAYoSeXEEkQODdfBOMNJdcLAYAoLAHBSeaAYoYIQc2LQnMjLH1Iwyz9Y+gJQB88WUAfPFslxgBjIywUkzxZQBvoCFctqFMzJcfsAECQQIwB8wwAjwgCwjiGCENUydttwgBDIywVQCM8WUAT6AhbLahLLHxLLP8ly+wCTNWwh4gPIUAT6AljPFgHPFszJ7VQA1ztRND6APpA+kDUMAfTP/oA+kAwUVGhUknHBfLiwSfC//LiwgWCCTEtAKAWvPLiw4IQe92X3sjLHxXLP1AD+gIizxYBzxbJcYAYyMsFJM8WcPoCy2rMyYBA+wBAE8hQBPoCWM8WAc8WzMntVIACB1AEGuQ9qJofQB9IH0gahgCaY+QwQgLxqKM3QFBCD3uy+9dCVj5cWLpn5j9ABgJ0CgR5CgCfQEsZ4sA54tmZPaqQAG6D2BdqJofQB9IH0gahhq3vDTA=="));
          stack.writeCell(Cell.fromBocBase64(
              "te6ccsECDAEAAo0AAAAADQASAGkA5wFGAckB4QIBAhcCUQJpART/APSkE/S88sgLAQIBYgILA6TQIMcAkl8E4AHQ0wPtRND6QAH4YfpAAfhi+gAB+GP6ADD4ZAFxsJJfBOD6QDBwIYBVAfpEMFi68vQB0x/TP/hCUkDHBeMC+EFSQMcF4wI0NEMTAwQJAfYzVSFsIQKCED6+VDG6juUB+gD6APoAMPhDUAOg+GP4RAGg+GT4Q4ED6Lz4RIED6LywUhCwjqeCEFbf64rIyx8Syz/4Q/oC+ET6AvhBzxYB+gL4QgHJ2zxw+GNw+GSRW+LI+EHPFvhCzxb4Q/oC+ET6AsntVJVbhA/y8OIKArYzVSExI4IQC/P0R7qOyxAjXwP4Q8IA+ETCALHy4FCCEIlEakLIyx/LP/hD+gL4RPoC+EHPFnD4QgLJEoBA2zxw+GNw+GTI+EHPFvhCzxb4Q/oC+ET6AsntVOMOBgUC/iOCEEz4KAO6juoxbBL6APoA+gAwIoED6LwigQPovLBSELDy4FH4QyOh+GP4RCKh+GT4Q8L/+ETC/7Dy4FCCEFbf64rIyx8Uyz9Y+gIB+gL4Qc8WAfoCcPhCAskSgEDbPMj4Qc8W+ELPFvhD+gL4RPoCye1U4DAxAYIQQqD7Q7oGBwAscYAYyMsFUATPFlAE+gISy2rMyQH7AAE6jpUgggiYloC88uBTggiYloCh+EFw2zzgMIQP8vAIAChwgBjIywVQA88WUAP6AstqyQH7AAFuMHB0+wICghAdQ5rguo6fghAdQ5rgyMsfyz/4Qc8W+ELPFvhD+gL4RPoCyds8f5JbcOLchA/y8AoALHGAGMjLBVADzxZw+gISy2rMyYMG+wAAQ6G6bdqJofSAA/DD9IAD8MX0AAPwx/QAYfDJ8IPwhfCH8InFhJmX"));

          return Future.value(ContractGetMethodResult(
            stack: TupleReader(stack.build()),
          ));
        },
      );

      test('should make on-chain request and return parsed response', () async {
        final contract = client.open(RouterV1());
        final data = await contract.getRouterData();
        expect(data.isLocked, equals(false));
        expect(
            data.adminAddress.equals(
                address("EQBJm7wS-5M9SmJ3xLMCj8Ol-JKLikGDj-GfDwL1_6b7cENC")),
            equals(true));
        expect(base64.encode(data.tempUpgrade.toBoc()),
            equals("te6cckEBAgEAFgABIQAAAAAAAAAAAAAAAAAAAAAgAQAAnpyZMQ=="));
      });
    });
  });
}
