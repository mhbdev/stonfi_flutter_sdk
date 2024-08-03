import 'package:flutter/material.dart';
import 'package:stonfi/contracts/contract.dart';
import 'package:tonutils/dataformat.dart';

import '../../constants.dart';

class VaultGasConstant {
  final BigInt withdrawFee;

  VaultGasConstant({
    required this.withdrawFee,
  });
}

class VaultV2 extends StonfiContract {
  static DexVersion version = DexVersion.v2;
  static VaultGasConstant gasConstants = VaultGasConstant(
    withdrawFee: Nano.fromString('0.3'),
  );

  VaultV2(InternalAddress address, {VaultGasConstant? gasConstants}) {
    this.address = address;
    VaultV2.gasConstants = gasConstants ?? VaultV2.gasConstants;
  }

  Cell createWithdrawFeeBody({
    BigInt? queryId,
  }) {
    return beginCell()
        .storeUint(DexOpCodes.WITHDRAW_FEE.op, 32)
        .storeUint(queryId ?? BigInt.zero, 64)
        .endCell();
  }

  Future<SenderArguments> getWithdrawFeeTxParams({
    BigInt? gasAmount,
    BigInt? queryId,
  }) async {
    final to = this.address;

    final body = createWithdrawFeeBody(
      queryId: queryId,
    );

    final value = gasAmount ?? gasConstants.withdrawFee;

    return SenderArguments(value: value, to: to, body: body);
  }

  Future<
      ({
        InternalAddress ownerAddress,
        InternalAddress tokenAddress,
        InternalAddress routerAddress,
        BigInt depositedAmount,
      })> getVaultData() async {
    final result = await stonfiProvider!.get('get_vault_data', []);
    return (
      ownerAddress: result.stack.readAddress(),
      tokenAddress: result.stack.readAddress(),
      routerAddress: result.stack.readAddress(),
      depositedAmount: result.stack.readBigInt(),
    );
  }
}
