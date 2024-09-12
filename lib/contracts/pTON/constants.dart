enum PtonOpCodes { TON_TRANSFER, DEPLOY_WALLET_V1, DEPLOY_WALLET_V2 }

extension PtonOpCodesValue on PtonOpCodes {
  BigInt get op => BigInt.from(
        switch (this) {
          PtonOpCodes.TON_TRANSFER => 0x01f3835d,
          PtonOpCodes.DEPLOY_WALLET_V1 => 0x6cc43573,
          PtonOpCodes.DEPLOY_WALLET_V2 => 0x4f5f4313,
        },
      );
}

enum PtonVersion {
  v1,
  v2,
}
