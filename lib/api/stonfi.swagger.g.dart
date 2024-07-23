// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stonfi.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetInfoSchema _$AssetInfoSchemaFromJson(Map<String, dynamic> json) =>
    AssetInfoSchema(
      balance: json['balance'] as String?,
      blacklisted: json['blacklisted'] as bool,
      community: json['community'] as bool,
      contractAddress: json['contract_address'] as String,
      decimals: (json['decimals'] as num).toInt(),
      defaultSymbol: json['default_symbol'] as bool,
      deprecated: json['deprecated'] as bool,
      dexPriceUsd: json['dex_price_usd'] as String?,
      dexUsdPrice: json['dex_usd_price'] as String?,
      displayName: json['display_name'] as String?,
      imageUrl: json['image_url'] as String?,
      kind: assetKindSchemaFromJson(json['kind']),
      priority: (json['priority'] as num).toInt(),
      symbol: json['symbol'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      taxable: json['taxable'] as bool,
      thirdPartyPriceUsd: json['third_party_price_usd'] as String?,
      thirdPartyUsdPrice: json['third_party_usd_price'] as String?,
      walletAddress: json['wallet_address'] as String?,
    );

Map<String, dynamic> _$AssetInfoSchemaToJson(AssetInfoSchema instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'blacklisted': instance.blacklisted,
      'community': instance.community,
      'contract_address': instance.contractAddress,
      'decimals': instance.decimals,
      'default_symbol': instance.defaultSymbol,
      'deprecated': instance.deprecated,
      'dex_price_usd': instance.dexPriceUsd,
      'dex_usd_price': instance.dexUsdPrice,
      'display_name': instance.displayName,
      'image_url': instance.imageUrl,
      'kind': assetKindSchemaToJson(instance.kind),
      'priority': instance.priority,
      'symbol': instance.symbol,
      'tags': instance.tags,
      'taxable': instance.taxable,
      'third_party_price_usd': instance.thirdPartyPriceUsd,
      'third_party_usd_price': instance.thirdPartyUsdPrice,
      'wallet_address': instance.walletAddress,
    };

AssetInfoSchemaV2 _$AssetInfoSchemaV2FromJson(Map<String, dynamic> json) =>
    AssetInfoSchemaV2(
      balance: json['balance'] as String?,
      contractAddress: json['contract_address'] as String,
      dexPriceUsd: json['dex_price_usd'] as String?,
      kind: assetKindSchemaFromJson(json['kind']),
      meta: json['meta'] == null
          ? null
          : AssetMetaSchemaV2.fromJson(json['meta'] as Map<String, dynamic>),
      pairPriority: (json['pair_priority'] as num?)?.toInt(),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      walletAddress: json['wallet_address'] as String?,
    );

Map<String, dynamic> _$AssetInfoSchemaV2ToJson(AssetInfoSchemaV2 instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'contract_address': instance.contractAddress,
      'dex_price_usd': instance.dexPriceUsd,
      'kind': assetKindSchemaToJson(instance.kind),
      'meta': instance.meta?.toJson(),
      'pair_priority': instance.pairPriority,
      'tags': instance.tags,
      'wallet_address': instance.walletAddress,
    };

AssetInfoScreenerSchema _$AssetInfoScreenerSchemaFromJson(
        Map<String, dynamic> json) =>
    AssetInfoScreenerSchema(
      circulatingSupply: json['circulatingSupply'] as String?,
      id: json['id'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      totalSupply: json['totalSupply'] as String,
    );

Map<String, dynamic> _$AssetInfoScreenerSchemaToJson(
        AssetInfoScreenerSchema instance) =>
    <String, dynamic>{
      'circulatingSupply': instance.circulatingSupply,
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'totalSupply': instance.totalSupply,
    };

AssetMetaSchemaV2 _$AssetMetaSchemaV2FromJson(Map<String, dynamic> json) =>
    AssetMetaSchemaV2(
      decimals: (json['decimals'] as num?)?.toInt(),
      displayName: json['display_name'] as String?,
      imageUrl: json['image_url'] as String?,
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$AssetMetaSchemaV2ToJson(AssetMetaSchemaV2 instance) =>
    <String, dynamic>{
      'decimals': instance.decimals,
      'display_name': instance.displayName,
      'image_url': instance.imageUrl,
      'symbol': instance.symbol,
    };

BlockSchema _$BlockSchemaFromJson(Map<String, dynamic> json) => BlockSchema(
      blockNumber: (json['blockNumber'] as num).toInt(),
      blockTimestamp: (json['blockTimestamp'] as num).toInt(),
    );

Map<String, dynamic> _$BlockSchemaToJson(BlockSchema instance) =>
    <String, dynamic>{
      'blockNumber': instance.blockNumber,
      'blockTimestamp': instance.blockTimestamp,
    };

CmcPoolStats _$CmcPoolStatsFromJson(Map<String, dynamic> json) => CmcPoolStats(
      baseId: json['base_id'] as String,
      baseLiquidity: json['base_liquidity'] as String,
      baseName: json['base_name'] as String,
      baseSymbol: json['base_symbol'] as String,
      baseVolume: json['base_volume'] as String,
      lastPrice: json['last_price'] as String,
      quoteId: json['quote_id'] as String,
      quoteLiquidity: json['quote_liquidity'] as String,
      quoteName: json['quote_name'] as String,
      quoteSymbol: json['quote_symbol'] as String,
      quoteVolume: json['quote_volume'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$CmcPoolStatsToJson(CmcPoolStats instance) =>
    <String, dynamic>{
      'base_id': instance.baseId,
      'base_liquidity': instance.baseLiquidity,
      'base_name': instance.baseName,
      'base_symbol': instance.baseSymbol,
      'base_volume': instance.baseVolume,
      'last_price': instance.lastPrice,
      'quote_id': instance.quoteId,
      'quote_liquidity': instance.quoteLiquidity,
      'quote_name': instance.quoteName,
      'quote_symbol': instance.quoteSymbol,
      'quote_volume': instance.quoteVolume,
      'url': instance.url,
    };

DexStats _$DexStatsFromJson(Map<String, dynamic> json) => DexStats(
      trades: (json['trades'] as num).toInt(),
      tvl: json['tvl'] as String,
      uniqueWallets: (json['unique_wallets'] as num).toInt(),
      volumeUsd: json['volume_usd'] as String,
    );

Map<String, dynamic> _$DexStatsToJson(DexStats instance) => <String, dynamic>{
      'trades': instance.trades,
      'tvl': instance.tvl,
      'unique_wallets': instance.uniqueWallets,
      'volume_usd': instance.volumeUsd,
    };

EventSchema _$EventSchemaFromJson(Map<String, dynamic> json) => EventSchema(
      block: BlockSchema.fromJson(json['block'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventSchemaToJson(EventSchema instance) =>
    <String, dynamic>{
      'block': instance.block.toJson(),
    };

EventType _$EventTypeFromJson(Map<String, dynamic> json) => EventType();

Map<String, dynamic> _$EventTypeToJson(EventType instance) =>
    <String, dynamic>{};

FarmInfoSchema _$FarmInfoSchemaFromJson(Map<String, dynamic> json) =>
    FarmInfoSchema(
      apy: json['apy'] as String?,
      minStakeDurationS: json['min_stake_duration_s'] as String,
      minterAddress: json['minter_address'] as String,
      nftInfos: (json['nft_infos'] as List<dynamic>?)
              ?.map(
                  (e) => FarmNftInfoSchema.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      poolAddress: json['pool_address'] as String,
      rewardTokenAddress: json['reward_token_address'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$FarmInfoSchemaToJson(FarmInfoSchema instance) =>
    <String, dynamic>{
      'apy': instance.apy,
      'min_stake_duration_s': instance.minStakeDurationS,
      'minter_address': instance.minterAddress,
      'nft_infos': instance.nftInfos.map((e) => e.toJson()).toList(),
      'pool_address': instance.poolAddress,
      'reward_token_address': instance.rewardTokenAddress,
      'status': instance.status,
    };

FarmNftInfoSchema _$FarmNftInfoSchemaFromJson(Map<String, dynamic> json) =>
    FarmNftInfoSchema(
      address: json['address'] as String,
      createTimestamp: json['create_timestamp'] as String,
      minUnstakeTimestamp: json['min_unstake_timestamp'] as String,
      nonclaimedRewards: json['nonclaimed_rewards'] as String,
      rewards: (json['rewards'] as List<dynamic>?)
              ?.map((e) =>
                  FarmNftRewardInfoSchema.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      stakedTokens: json['staked_tokens'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$FarmNftInfoSchemaToJson(FarmNftInfoSchema instance) =>
    <String, dynamic>{
      'address': instance.address,
      'create_timestamp': instance.createTimestamp,
      'min_unstake_timestamp': instance.minUnstakeTimestamp,
      'nonclaimed_rewards': instance.nonclaimedRewards,
      'rewards': instance.rewards.map((e) => e.toJson()).toList(),
      'staked_tokens': instance.stakedTokens,
      'status': instance.status,
    };

FarmNftRewardInfoSchema _$FarmNftRewardInfoSchemaFromJson(
        Map<String, dynamic> json) =>
    FarmNftRewardInfoSchema(
      address: json['address'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$FarmNftRewardInfoSchemaToJson(
        FarmNftRewardInfoSchema instance) =>
    <String, dynamic>{
      'address': instance.address,
      'amount': instance.amount,
    };

LiquidityEvent _$LiquidityEventFromJson(Map<String, dynamic> json) =>
    LiquidityEvent(
      amount0: json['amount0'] as String,
      amount1: json['amount1'] as String,
      eventIndex: (json['eventIndex'] as num).toInt(),
      maker: json['maker'] as String,
      pairId: json['pairId'] as String,
      reserves: json['reserves'] == null
          ? null
          : Reserves.fromJson(json['reserves'] as Map<String, dynamic>),
      txnId: json['txnId'] as String,
      txnIndex: (json['txnIndex'] as num).toInt(),
    );

Map<String, dynamic> _$LiquidityEventToJson(LiquidityEvent instance) =>
    <String, dynamic>{
      'amount0': instance.amount0,
      'amount1': instance.amount1,
      'eventIndex': instance.eventIndex,
      'maker': instance.maker,
      'pairId': instance.pairId,
      'reserves': instance.reserves?.toJson(),
      'txnId': instance.txnId,
      'txnIndex': instance.txnIndex,
    };

OperationStat _$OperationStatFromJson(Map<String, dynamic> json) =>
    OperationStat(
      asset0Address: json['asset0_address'] as String,
      asset0Amount: json['asset0_amount'] as String,
      asset0Delta: json['asset0_delta'] as String,
      asset0Reserve: json['asset0_reserve'] as String,
      asset1Address: json['asset1_address'] as String,
      asset1Amount: json['asset1_amount'] as String,
      asset1Delta: json['asset1_delta'] as String,
      asset1Reserve: json['asset1_reserve'] as String,
      destinationWalletAddress: json['destination_wallet_address'] as String,
      exitCode: json['exit_code'] as String,
      feeAssetAddress: json['fee_asset_address'] as String?,
      lpFeeAmount: json['lp_fee_amount'] as String,
      lpTokenDelta: json['lp_token_delta'] as String,
      lpTokenSupply: json['lp_token_supply'] as String,
      operationType: json['operation_type'] as String,
      poolAddress: json['pool_address'] as String,
      poolTxHash: json['pool_tx_hash'] as String,
      poolTxLt: (json['pool_tx_lt'] as num).toInt(),
      poolTxTimestamp: json['pool_tx_timestamp'] as String,
      protocolFeeAmount: json['protocol_fee_amount'] as String,
      referralAddress: json['referral_address'] as String?,
      referralFeeAmount: json['referral_fee_amount'] as String,
      routerAddress: json['router_address'] as String,
      success: json['success'] as bool,
      walletAddress: json['wallet_address'] as String,
      walletTxHash: json['wallet_tx_hash'] as String,
      walletTxLt: json['wallet_tx_lt'] as String,
      walletTxTimestamp: json['wallet_tx_timestamp'] as String,
    );

Map<String, dynamic> _$OperationStatToJson(OperationStat instance) =>
    <String, dynamic>{
      'asset0_address': instance.asset0Address,
      'asset0_amount': instance.asset0Amount,
      'asset0_delta': instance.asset0Delta,
      'asset0_reserve': instance.asset0Reserve,
      'asset1_address': instance.asset1Address,
      'asset1_amount': instance.asset1Amount,
      'asset1_delta': instance.asset1Delta,
      'asset1_reserve': instance.asset1Reserve,
      'destination_wallet_address': instance.destinationWalletAddress,
      'exit_code': instance.exitCode,
      'fee_asset_address': instance.feeAssetAddress,
      'lp_fee_amount': instance.lpFeeAmount,
      'lp_token_delta': instance.lpTokenDelta,
      'lp_token_supply': instance.lpTokenSupply,
      'operation_type': instance.operationType,
      'pool_address': instance.poolAddress,
      'pool_tx_hash': instance.poolTxHash,
      'pool_tx_lt': instance.poolTxLt,
      'pool_tx_timestamp': instance.poolTxTimestamp,
      'protocol_fee_amount': instance.protocolFeeAmount,
      'referral_address': instance.referralAddress,
      'referral_fee_amount': instance.referralFeeAmount,
      'router_address': instance.routerAddress,
      'success': instance.success,
      'wallet_address': instance.walletAddress,
      'wallet_tx_hash': instance.walletTxHash,
      'wallet_tx_lt': instance.walletTxLt,
      'wallet_tx_timestamp': instance.walletTxTimestamp,
    };

OperationStatus _$OperationStatusFromJson(Map<String, dynamic> json) =>
    OperationStatus(
      address: json['address'] as String,
      balanceDeltas: json['balance_deltas'] as String,
      coins: json['coins'] as String,
      exitCode: json['exit_code'] as String,
      logicalTime: json['logical_time'] as String,
      queryId: json['query_id'] as String,
      txHash: json['tx_hash'] as String,
    );

Map<String, dynamic> _$OperationStatusToJson(OperationStatus instance) =>
    <String, dynamic>{
      'address': instance.address,
      'balance_deltas': instance.balanceDeltas,
      'coins': instance.coins,
      'exit_code': instance.exitCode,
      'logical_time': instance.logicalTime,
      'query_id': instance.queryId,
      'tx_hash': instance.txHash,
    };

OperationsInfo _$OperationsInfoFromJson(Map<String, dynamic> json) =>
    OperationsInfo(
      asset0Info:
          AssetInfoSchema.fromJson(json['asset0_info'] as Map<String, dynamic>),
      asset1Info:
          AssetInfoSchema.fromJson(json['asset1_info'] as Map<String, dynamic>),
      operation:
          OperationStat.fromJson(json['operation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OperationsInfoToJson(OperationsInfo instance) =>
    <String, dynamic>{
      'asset0_info': instance.asset0Info.toJson(),
      'asset1_info': instance.asset1Info.toJson(),
      'operation': instance.operation.toJson(),
    };

PoolInfoSchema _$PoolInfoSchemaFromJson(Map<String, dynamic> json) =>
    PoolInfoSchema(
      address: json['address'] as String,
      apy1d: json['apy_1d'] as String?,
      apy30d: json['apy_30d'] as String?,
      apy7d: json['apy_7d'] as String?,
      collectedToken0ProtocolFee:
          json['collected_token0_protocol_fee'] as String,
      collectedToken1ProtocolFee:
          json['collected_token1_protocol_fee'] as String,
      deprecated: json['deprecated'] as bool,
      lpAccountAddress: json['lp_account_address'] as String?,
      lpBalance: json['lp_balance'] as String?,
      lpFee: json['lp_fee'] as String,
      lpPriceUsd: json['lp_price_usd'] as String?,
      lpTotalSupply: json['lp_total_supply'] as String,
      lpTotalSupplyUsd: json['lp_total_supply_usd'] as String?,
      lpWalletAddress: json['lp_wallet_address'] as String?,
      protocolFee: json['protocol_fee'] as String,
      protocolFeeAddress: json['protocol_fee_address'] as String,
      refFee: json['ref_fee'] as String,
      reserve0: json['reserve0'] as String,
      reserve1: json['reserve1'] as String,
      routerAddress: json['router_address'] as String,
      token0Address: json['token0_address'] as String,
      token0Balance: json['token0_balance'] as String?,
      token1Address: json['token1_address'] as String,
      token1Balance: json['token1_balance'] as String?,
    );

Map<String, dynamic> _$PoolInfoSchemaToJson(PoolInfoSchema instance) =>
    <String, dynamic>{
      'address': instance.address,
      'apy_1d': instance.apy1d,
      'apy_30d': instance.apy30d,
      'apy_7d': instance.apy7d,
      'collected_token0_protocol_fee': instance.collectedToken0ProtocolFee,
      'collected_token1_protocol_fee': instance.collectedToken1ProtocolFee,
      'deprecated': instance.deprecated,
      'lp_account_address': instance.lpAccountAddress,
      'lp_balance': instance.lpBalance,
      'lp_fee': instance.lpFee,
      'lp_price_usd': instance.lpPriceUsd,
      'lp_total_supply': instance.lpTotalSupply,
      'lp_total_supply_usd': instance.lpTotalSupplyUsd,
      'lp_wallet_address': instance.lpWalletAddress,
      'protocol_fee': instance.protocolFee,
      'protocol_fee_address': instance.protocolFeeAddress,
      'ref_fee': instance.refFee,
      'reserve0': instance.reserve0,
      'reserve1': instance.reserve1,
      'router_address': instance.routerAddress,
      'token0_address': instance.token0Address,
      'token0_balance': instance.token0Balance,
      'token1_address': instance.token1Address,
      'token1_balance': instance.token1Balance,
    };

PoolInfoScreenerSchema _$PoolInfoScreenerSchemaFromJson(
        Map<String, dynamic> json) =>
    PoolInfoScreenerSchema(
      asset0Id: json['asset0Id'] as String,
      asset1Id: json['asset1Id'] as String,
      createdAtBlockNumber: (json['createdAtBlockNumber'] as num?)?.toInt(),
      createdAtBlockTimestamp:
          (json['createdAtBlockTimestamp'] as num?)?.toInt(),
      createdAtTxnId: json['createdAtTxnId'] as String?,
      feeBps: (json['feeBps'] as num?)?.toInt(),
      id: json['id'] as String,
    );

Map<String, dynamic> _$PoolInfoScreenerSchemaToJson(
        PoolInfoScreenerSchema instance) =>
    <String, dynamic>{
      'asset0Id': instance.asset0Id,
      'asset1Id': instance.asset1Id,
      'createdAtBlockNumber': instance.createdAtBlockNumber,
      'createdAtBlockTimestamp': instance.createdAtBlockTimestamp,
      'createdAtTxnId': instance.createdAtTxnId,
      'feeBps': instance.feeBps,
      'id': instance.id,
    };

PoolStats _$PoolStatsFromJson(Map<String, dynamic> json) => PoolStats(
      apy: json['apy'] as String?,
      baseId: json['base_id'] as String,
      baseLiquidity: json['base_liquidity'] as String,
      baseName: json['base_name'] as String,
      baseSymbol: json['base_symbol'] as String,
      baseVolume: json['base_volume'] as String,
      lastPrice: json['last_price'] as String,
      lpPrice: json['lp_price'] as String,
      lpPriceUsd: json['lp_price_usd'] as String,
      poolAddress: json['pool_address'] as String,
      quoteId: json['quote_id'] as String,
      quoteLiquidity: json['quote_liquidity'] as String,
      quoteName: json['quote_name'] as String,
      quoteSymbol: json['quote_symbol'] as String,
      quoteVolume: json['quote_volume'] as String,
      routerAddress: json['router_address'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PoolStatsToJson(PoolStats instance) => <String, dynamic>{
      'apy': instance.apy,
      'base_id': instance.baseId,
      'base_liquidity': instance.baseLiquidity,
      'base_name': instance.baseName,
      'base_symbol': instance.baseSymbol,
      'base_volume': instance.baseVolume,
      'last_price': instance.lastPrice,
      'lp_price': instance.lpPrice,
      'lp_price_usd': instance.lpPriceUsd,
      'pool_address': instance.poolAddress,
      'quote_id': instance.quoteId,
      'quote_liquidity': instance.quoteLiquidity,
      'quote_name': instance.quoteName,
      'quote_symbol': instance.quoteSymbol,
      'quote_volume': instance.quoteVolume,
      'router_address': instance.routerAddress,
      'url': instance.url,
    };

Reserves _$ReservesFromJson(Map<String, dynamic> json) => Reserves(
      asset0: json['asset0'] as String,
      asset1: json['asset1'] as String,
    );

Map<String, dynamic> _$ReservesToJson(Reserves instance) => <String, dynamic>{
      'asset0': instance.asset0,
      'asset1': instance.asset1,
    };

SwapEvent _$SwapEventFromJson(Map<String, dynamic> json) => SwapEvent(
      amount0In: json['amount0In'] as String?,
      amount0Out: json['amount0Out'] as String?,
      amount1In: json['amount1In'] as String?,
      amount1Out: json['amount1Out'] as String?,
      eventIndex: (json['eventIndex'] as num).toInt(),
      maker: json['maker'] as String,
      pairId: json['pairId'] as String,
      priceNative: json['priceNative'] as String,
      reserves: json['reserves'] == null
          ? null
          : Reserves.fromJson(json['reserves'] as Map<String, dynamic>),
      txnId: json['txnId'] as String,
      txnIndex: (json['txnIndex'] as num).toInt(),
    );

Map<String, dynamic> _$SwapEventToJson(SwapEvent instance) => <String, dynamic>{
      'amount0In': instance.amount0In,
      'amount0Out': instance.amount0Out,
      'amount1In': instance.amount1In,
      'amount1Out': instance.amount1Out,
      'eventIndex': instance.eventIndex,
      'maker': instance.maker,
      'pairId': instance.pairId,
      'priceNative': instance.priceNative,
      'reserves': instance.reserves?.toJson(),
      'txnId': instance.txnId,
      'txnIndex': instance.txnIndex,
    };

AddressResponse$Response _$AddressResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    AddressResponse$Response(
      address: json['address'] as String,
    );

Map<String, dynamic> _$AddressResponse$ResponseToJson(
        AddressResponse$Response instance) =>
    <String, dynamic>{
      'address': instance.address,
    };

AssetInfoScreenerResponse$Response _$AssetInfoScreenerResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    AssetInfoScreenerResponse$Response(
      asset: AssetInfoScreenerSchema.fromJson(
          json['asset'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssetInfoScreenerResponse$ResponseToJson(
        AssetInfoScreenerResponse$Response instance) =>
    <String, dynamic>{
      'asset': instance.asset.toJson(),
    };

AssetListResponse$Response _$AssetListResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    AssetListResponse$Response(
      assetList: (json['asset_list'] as List<dynamic>?)
              ?.map((e) => AssetInfoSchema.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AssetListResponse$ResponseToJson(
        AssetListResponse$Response instance) =>
    <String, dynamic>{
      'asset_list': instance.assetList.map((e) => e.toJson()).toList(),
    };

AssetListResponseV2$Response _$AssetListResponseV2$ResponseFromJson(
        Map<String, dynamic> json) =>
    AssetListResponseV2$Response(
      assetList: (json['asset_list'] as List<dynamic>?)
              ?.map(
                  (e) => AssetInfoSchemaV2.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AssetListResponseV2$ResponseToJson(
        AssetListResponseV2$Response instance) =>
    <String, dynamic>{
      'asset_list': instance.assetList.map((e) => e.toJson()).toList(),
    };

AssetResponse$Response _$AssetResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    AssetResponse$Response(
      asset: AssetInfoSchema.fromJson(json['asset'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssetResponse$ResponseToJson(
        AssetResponse$Response instance) =>
    <String, dynamic>{
      'asset': instance.asset.toJson(),
    };

DexStatsResponse$Response _$DexStatsResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    DexStatsResponse$Response(
      since: json['since'] as String,
      stats: DexStats.fromJson(json['stats'] as Map<String, dynamic>),
      until: json['until'] as String,
    );

Map<String, dynamic> _$DexStatsResponse$ResponseToJson(
        DexStatsResponse$Response instance) =>
    <String, dynamic>{
      'since': instance.since,
      'stats': instance.stats.toJson(),
      'until': instance.until,
    };

EventsResponse$Response _$EventsResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    EventsResponse$Response(
      event: EventSchema.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventsResponse$ResponseToJson(
        EventsResponse$Response instance) =>
    <String, dynamic>{
      'event': instance.event.toJson(),
    };

FarmListResponse$Response _$FarmListResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    FarmListResponse$Response(
      farmList: (json['farm_list'] as List<dynamic>?)
              ?.map((e) => FarmInfoSchema.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FarmListResponse$ResponseToJson(
        FarmListResponse$Response instance) =>
    <String, dynamic>{
      'farm_list': instance.farmList.map((e) => e.toJson()).toList(),
    };

FarmResponse$Response _$FarmResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    FarmResponse$Response(
      farm: FarmInfoSchema.fromJson(json['farm'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FarmResponse$ResponseToJson(
        FarmResponse$Response instance) =>
    <String, dynamic>{
      'farm': instance.farm.toJson(),
    };

LatestBlockResponse$Response _$LatestBlockResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    LatestBlockResponse$Response(
      block: BlockSchema.fromJson(json['block'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LatestBlockResponse$ResponseToJson(
        LatestBlockResponse$Response instance) =>
    <String, dynamic>{
      'block': instance.block.toJson(),
    };

MarketListResponse$Response _$MarketListResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    MarketListResponse$Response(
      pairs:
          (json['pairs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$MarketListResponse$ResponseToJson(
        MarketListResponse$Response instance) =>
    <String, dynamic>{
      'pairs': instance.pairs,
    };

OperationStatusResponse$Response _$OperationStatusResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    OperationStatusResponse$Response();

Map<String, dynamic> _$OperationStatusResponse$ResponseToJson(
        OperationStatusResponse$Response instance) =>
    <String, dynamic>{};

OperationsResponse$Response _$OperationsResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    OperationsResponse$Response(
      operations: (json['operations'] as List<dynamic>?)
              ?.map((e) => OperationsInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OperationsResponse$ResponseToJson(
        OperationsResponse$Response instance) =>
    <String, dynamic>{
      'operations': instance.operations.map((e) => e.toJson()).toList(),
    };

PoolInfoScreenerResponse$Response _$PoolInfoScreenerResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    PoolInfoScreenerResponse$Response(
      pair:
          PoolInfoScreenerSchema.fromJson(json['pair'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PoolInfoScreenerResponse$ResponseToJson(
        PoolInfoScreenerResponse$Response instance) =>
    <String, dynamic>{
      'pair': instance.pair.toJson(),
    };

PoolListResponse$Response _$PoolListResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    PoolListResponse$Response(
      poolList: (json['pool_list'] as List<dynamic>?)
              ?.map((e) => PoolInfoSchema.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PoolListResponse$ResponseToJson(
        PoolListResponse$Response instance) =>
    <String, dynamic>{
      'pool_list': instance.poolList.map((e) => e.toJson()).toList(),
    };

PoolResponse$Response _$PoolResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    PoolResponse$Response(
      pool: PoolInfoSchema.fromJson(json['pool'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PoolResponse$ResponseToJson(
        PoolResponse$Response instance) =>
    <String, dynamic>{
      'pool': instance.pool.toJson(),
    };

PoolStatsResponse$Response _$PoolStatsResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    PoolStatsResponse$Response(
      since: json['since'] as String,
      stats: (json['stats'] as List<dynamic>?)
              ?.map((e) => PoolStats.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      uniqueWalletsCount: (json['unique_wallets_count'] as num).toInt(),
      until: json['until'] as String,
    );

Map<String, dynamic> _$PoolStatsResponse$ResponseToJson(
        PoolStatsResponse$Response instance) =>
    <String, dynamic>{
      'since': instance.since,
      'stats': instance.stats.map((e) => e.toJson()).toList(),
      'unique_wallets_count': instance.uniqueWalletsCount,
      'until': instance.until,
    };

SimulateSwapResponse$Response _$SimulateSwapResponse$ResponseFromJson(
        Map<String, dynamic> json) =>
    SimulateSwapResponse$Response(
      askAddress: json['ask_address'] as String,
      askJettonWallet: json['ask_jetton_wallet'] as String,
      askUnits: json['ask_units'] as String,
      feeAddress: json['fee_address'] as String,
      feePercent: json['fee_percent'] as String,
      feeUnits: json['fee_units'] as String,
      minAskUnits: json['min_ask_units'] as String,
      offerAddress: json['offer_address'] as String,
      offerJettonWallet: json['offer_jetton_wallet'] as String,
      offerUnits: json['offer_units'] as String,
      poolAddress: json['pool_address'] as String,
      priceImpact: json['price_impact'] as String,
      routerAddress: json['router_address'] as String,
      slippageTolerance: json['slippage_tolerance'] as String,
      swapRate: json['swap_rate'] as String,
    );

Map<String, dynamic> _$SimulateSwapResponse$ResponseToJson(
        SimulateSwapResponse$Response instance) =>
    <String, dynamic>{
      'ask_address': instance.askAddress,
      'ask_jetton_wallet': instance.askJettonWallet,
      'ask_units': instance.askUnits,
      'fee_address': instance.feeAddress,
      'fee_percent': instance.feePercent,
      'fee_units': instance.feeUnits,
      'min_ask_units': instance.minAskUnits,
      'offer_address': instance.offerAddress,
      'offer_jetton_wallet': instance.offerJettonWallet,
      'offer_units': instance.offerUnits,
      'pool_address': instance.poolAddress,
      'price_impact': instance.priceImpact,
      'router_address': instance.routerAddress,
      'slippage_tolerance': instance.slippageTolerance,
      'swap_rate': instance.swapRate,
    };
