enum DexOpCodes {
  SWAP,
  CROSS_SWAP,
  PROVIDE_LP,
  CROSS_PROVIDE_LP,
  DIRECT_ADD_LIQUIDITY,
  REFUND_ME,
  RESET_GAS,
  COLLECT_FEES,
  BURN,
  WITHDRAW_FEE,
}

extension DexOpCodeValue on DexOpCodes {
  BigInt get op => BigInt.from(
      switch(this) {
        DexOpCodes.SWAP => 0x25938561,
        DexOpCodes.CROSS_SWAP => 0xffffffef,
        DexOpCodes.PROVIDE_LP => 0xfcf9e58f,
        DexOpCodes.CROSS_PROVIDE_LP => 0xfffffeff,
        DexOpCodes.DIRECT_ADD_LIQUIDITY => 0x4cf82803,
        DexOpCodes.REFUND_ME => 0x0bf3f447,
        DexOpCodes.RESET_GAS => 0x42a0fb43,
        DexOpCodes.COLLECT_FEES => 0x1fcb7d3d,
        DexOpCodes.BURN => 0x595f07bc,
        DexOpCodes.WITHDRAW_FEE => 0x45ed2dc7,
      }
  );
}

enum DexVersion {
  v1,
  v2,
}