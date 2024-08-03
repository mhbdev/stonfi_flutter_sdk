enum PtonOpCodes { TON_TRANSFER }

extension PtonOpCodesValue on PtonOpCodes {
  BigInt get op => BigInt.from(switch (this) {
        PtonOpCodes.TON_TRANSFER => 0x01f3835d,
      });
}

enum PtonVersion {
  v1,
  v2,
}
