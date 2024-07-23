// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart' as chopper;
import 'stonfi.enums.swagger.dart' as enums;
export 'stonfi.enums.swagger.dart';

part 'stonfi.swagger.chopper.dart';
part 'stonfi.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Stonfi extends ChopperService {
  static Stonfi create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$Stonfi(client);
    }

    final newClient = ChopperClient(
        services: [_$Stonfi()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$Stonfi(newClient);
  }

  ///
  Future<chopper.Response<List<Object>>> exportCmcV1Get() {
    return _exportCmcV1Get();
  }

  ///
  @Get(path: '/export/cmc/v1')
  Future<chopper.Response<List<Object>>> _exportCmcV1Get();

  ///
  ///@param address
  Future<chopper.Response<AssetInfoScreenerResponse$Response>>
      exportDexscreenerV1AssetAddressGet({required String? address}) {
    generatedMapping.putIfAbsent(AssetInfoScreenerResponse$Response,
        () => AssetInfoScreenerResponse$Response.fromJsonFactory);

    return _exportDexscreenerV1AssetAddressGet(address: address);
  }

  ///
  ///@param address
  @Get(path: '/export/dexscreener/v1/asset/{address}')
  Future<chopper.Response<AssetInfoScreenerResponse$Response>>
      _exportDexscreenerV1AssetAddressGet(
          {@Path('address') required String? address});

  ///
  ///@param fromBlock Block number of the response events start (inclusive)
  ///@param toBlock Block number of the response events end (inclusive)
  Future<chopper.Response<EventsResponse$Response>>
      exportDexscreenerV1EventsGet({
    required int? fromBlock,
    required int? toBlock,
  }) {
    generatedMapping.putIfAbsent(
        EventsResponse$Response, () => EventsResponse$Response.fromJsonFactory);

    return _exportDexscreenerV1EventsGet(
        fromBlock: fromBlock, toBlock: toBlock);
  }

  ///
  ///@param fromBlock Block number of the response events start (inclusive)
  ///@param toBlock Block number of the response events end (inclusive)
  @Get(path: '/export/dexscreener/v1/events')
  Future<chopper.Response<EventsResponse$Response>>
      _exportDexscreenerV1EventsGet({
    @Query('fromBlock') required int? fromBlock,
    @Query('toBlock') required int? toBlock,
  });

  ///
  Future<chopper.Response<LatestBlockResponse$Response>>
      exportDexscreenerV1LatestBlockGet() {
    generatedMapping.putIfAbsent(LatestBlockResponse$Response,
        () => LatestBlockResponse$Response.fromJsonFactory);

    return _exportDexscreenerV1LatestBlockGet();
  }

  ///
  @Get(path: '/export/dexscreener/v1/latest-block')
  Future<chopper.Response<LatestBlockResponse$Response>>
      _exportDexscreenerV1LatestBlockGet();

  ///
  ///@param address
  Future<chopper.Response<PoolInfoScreenerResponse$Response>>
      exportDexscreenerV1PairAddressGet({required String? address}) {
    generatedMapping.putIfAbsent(PoolInfoScreenerResponse$Response,
        () => PoolInfoScreenerResponse$Response.fromJsonFactory);

    return _exportDexscreenerV1PairAddressGet(address: address);
  }

  ///
  ///@param address
  @Get(path: '/export/dexscreener/v1/pair/{address}')
  Future<chopper.Response<PoolInfoScreenerResponse$Response>>
      _exportDexscreenerV1PairAddressGet(
          {@Path('address') required String? address});

  ///
  Future<chopper.Response<AssetListResponse$Response>> v1AssetsGet() {
    generatedMapping.putIfAbsent(AssetListResponse$Response,
        () => AssetListResponse$Response.fromJsonFactory);

    return _v1AssetsGet();
  }

  ///
  @Get(path: '/v1/assets')
  Future<chopper.Response<AssetListResponse$Response>> _v1AssetsGet();

  ///
  ///@param condition Condition
  ///@param unconditional_assets Unconditional assets
  ///@param wallet_address Wallet address
  Future<chopper.Response<AssetListResponseV2$Response>> v1AssetsQueryPost({
    String? condition,
    List<String>? unconditionalAssets,
    String? walletAddress,
  }) {
    generatedMapping.putIfAbsent(AssetListResponseV2$Response,
        () => AssetListResponseV2$Response.fromJsonFactory);

    return _v1AssetsQueryPost(
        condition: condition,
        unconditionalAssets: unconditionalAssets,
        walletAddress: walletAddress);
  }

  ///
  ///@param condition Condition
  ///@param unconditional_assets Unconditional assets
  ///@param wallet_address Wallet address
  @Post(
    path: '/v1/assets/query',
    optionalBody: true,
  )
  Future<chopper.Response<AssetListResponseV2$Response>> _v1AssetsQueryPost({
    @Query('condition') String? condition,
    @Query('unconditional_assets') List<String>? unconditionalAssets,
    @Query('wallet_address') String? walletAddress,
  });

  ///
  ///@param search_string Search string (by partial display name or symbol) or by full contract address
  ///@param condition Condition
  ///@param wallet_address Wallet address
  Future<chopper.Response<AssetListResponseV2$Response>> v1AssetsSearchPost({
    required String? searchString,
    String? condition,
    String? walletAddress,
  }) {
    generatedMapping.putIfAbsent(AssetListResponseV2$Response,
        () => AssetListResponseV2$Response.fromJsonFactory);

    return _v1AssetsSearchPost(
        searchString: searchString,
        condition: condition,
        walletAddress: walletAddress);
  }

  ///
  ///@param search_string Search string (by partial display name or symbol) or by full contract address
  ///@param condition Condition
  ///@param wallet_address Wallet address
  @Post(
    path: '/v1/assets/search',
    optionalBody: true,
  )
  Future<chopper.Response<AssetListResponseV2$Response>> _v1AssetsSearchPost({
    @Query('search_string') required String? searchString,
    @Query('condition') String? condition,
    @Query('wallet_address') String? walletAddress,
  });

  ///
  ///@param addr_str
  Future<chopper.Response<AssetResponse$Response>> v1AssetsAddrStrGet(
      {required String? addrStr}) {
    generatedMapping.putIfAbsent(
        AssetResponse$Response, () => AssetResponse$Response.fromJsonFactory);

    return _v1AssetsAddrStrGet(addrStr: addrStr);
  }

  ///
  ///@param addr_str
  @Get(path: '/v1/assets/{addr_str}')
  Future<chopper.Response<AssetResponse$Response>> _v1AssetsAddrStrGet(
      {@Path('addr_str') required String? addrStr});

  ///
  Future<chopper.Response<FarmListResponse$Response>> v1FarmsGet() {
    generatedMapping.putIfAbsent(FarmListResponse$Response,
        () => FarmListResponse$Response.fromJsonFactory);

    return _v1FarmsGet();
  }

  ///
  @Get(path: '/v1/farms')
  Future<chopper.Response<FarmListResponse$Response>> _v1FarmsGet();

  ///
  ///@param addr_str
  Future<chopper.Response<FarmResponse$Response>> v1FarmsAddrStrGet(
      {required String? addrStr}) {
    generatedMapping.putIfAbsent(
        FarmResponse$Response, () => FarmResponse$Response.fromJsonFactory);

    return _v1FarmsAddrStrGet(addrStr: addrStr);
  }

  ///
  ///@param addr_str
  @Get(path: '/v1/farms/{addr_str}')
  Future<chopper.Response<FarmResponse$Response>> _v1FarmsAddrStrGet(
      {@Path('addr_str') required String? addrStr});

  ///
  ///@param pool_addr_str
  Future<chopper.Response<FarmListResponse$Response>>
      v1FarmsByPoolPoolAddrStrGet({required String? poolAddrStr}) {
    generatedMapping.putIfAbsent(FarmListResponse$Response,
        () => FarmListResponse$Response.fromJsonFactory);

    return _v1FarmsByPoolPoolAddrStrGet(poolAddrStr: poolAddrStr);
  }

  ///
  ///@param pool_addr_str
  @Get(path: '/v1/farms_by_pool/{pool_addr_str}')
  Future<chopper.Response<FarmListResponse$Response>>
      _v1FarmsByPoolPoolAddrStrGet(
          {@Path('pool_addr_str') required String? poolAddrStr});

  ///
  ///@param owner_address Address of the owner
  ///@param addr_str
  Future<chopper.Response<AddressResponse$Response>> v1JettonAddrStrAddressGet({
    required String? ownerAddress,
    required String? addrStr,
  }) {
    generatedMapping.putIfAbsent(AddressResponse$Response,
        () => AddressResponse$Response.fromJsonFactory);

    return _v1JettonAddrStrAddressGet(
        ownerAddress: ownerAddress, addrStr: addrStr);
  }

  ///
  ///@param owner_address Address of the owner
  ///@param addr_str
  @Get(path: '/v1/jetton/{addr_str}/address')
  Future<chopper.Response<AddressResponse$Response>>
      _v1JettonAddrStrAddressGet({
    @Query('owner_address') required String? ownerAddress,
    @Path('addr_str') required String? addrStr,
  });

  ///
  Future<chopper.Response<MarketListResponse$Response>> v1MarketsGet() {
    generatedMapping.putIfAbsent(MarketListResponse$Response,
        () => MarketListResponse$Response.fromJsonFactory);

    return _v1MarketsGet();
  }

  ///
  @Get(path: '/v1/markets')
  Future<chopper.Response<MarketListResponse$Response>> _v1MarketsGet();

  ///
  Future<chopper.Response<PoolListResponse$Response>> v1PoolsGet() {
    generatedMapping.putIfAbsent(PoolListResponse$Response,
        () => PoolListResponse$Response.fromJsonFactory);

    return _v1PoolsGet();
  }

  ///
  @Get(path: '/v1/pools')
  Future<chopper.Response<PoolListResponse$Response>> _v1PoolsGet();

  ///
  ///@param addr_str
  Future<chopper.Response<PoolListResponse$Response>> v1PoolsAddrStrGet(
      {required String? addrStr}) {
    generatedMapping.putIfAbsent(PoolListResponse$Response,
        () => PoolListResponse$Response.fromJsonFactory);

    return _v1PoolsAddrStrGet(addrStr: addrStr);
  }

  ///
  ///@param addr_str
  @Get(path: '/v1/pools/{addr_str}')
  Future<chopper.Response<PoolListResponse$Response>> _v1PoolsAddrStrGet(
      {@Path('addr_str') required String? addrStr});

  ///
  ///@param offer_address The address of the token we want to sell
  ///@param ask_address The address of the token we want to buy
  ///@param units Number of token units we want to sell
  ///@param slippage_tolerance The maximum possible difference between the rates that we expect and which will actually be, in fractions (for example, 0.001 is 0.1%)
  ///@param referral_address Referral address
  Future<chopper.Response<SimulateSwapResponse$Response>>
      v1ReverseSwapSimulatePost({
    required String? offerAddress,
    required String? askAddress,
    required String? units,
    required String? slippageTolerance,
    String? referralAddress,
  }) {
    generatedMapping.putIfAbsent(SimulateSwapResponse$Response,
        () => SimulateSwapResponse$Response.fromJsonFactory);

    return _v1ReverseSwapSimulatePost(
        offerAddress: offerAddress,
        askAddress: askAddress,
        units: units,
        slippageTolerance: slippageTolerance,
        referralAddress: referralAddress);
  }

  ///
  ///@param offer_address The address of the token we want to sell
  ///@param ask_address The address of the token we want to buy
  ///@param units Number of token units we want to sell
  ///@param slippage_tolerance The maximum possible difference between the rates that we expect and which will actually be, in fractions (for example, 0.001 is 0.1%)
  ///@param referral_address Referral address
  @Post(
    path: '/v1/reverse_swap/simulate',
    optionalBody: true,
  )
  Future<chopper.Response<SimulateSwapResponse$Response>>
      _v1ReverseSwapSimulatePost({
    @Query('offer_address') required String? offerAddress,
    @Query('ask_address') required String? askAddress,
    @Query('units') required String? units,
    @Query('slippage_tolerance') required String? slippageTolerance,
    @Query('referral_address') String? referralAddress,
  });

  ///
  ///@param since Time since stats are requested (YYYY-MM-DDTHH:MM:SS)
  ///@param until Time until stats are requested (YYYY-MM-DDTHH:MM:SS)
  Future<chopper.Response<DexStatsResponse$Response>> v1StatsDexGet({
    String? since,
    String? until,
  }) {
    generatedMapping.putIfAbsent(DexStatsResponse$Response,
        () => DexStatsResponse$Response.fromJsonFactory);

    return _v1StatsDexGet(since: since, until: until);
  }

  ///
  ///@param since Time since stats are requested (YYYY-MM-DDTHH:MM:SS)
  ///@param until Time until stats are requested (YYYY-MM-DDTHH:MM:SS)
  @Get(path: '/v1/stats/dex')
  Future<chopper.Response<DexStatsResponse$Response>> _v1StatsDexGet({
    @Query('since') String? since,
    @Query('until') String? until,
  });

  ///
  ///@param since Time since the stats are requested (YYYY-MM-DDTHH:MM:SS)
  ///@param until Time until pool stats are requested (YYYY-MM-DDTHH:MM:SS)
  Future<chopper.Response<OperationsResponse$Response>> v1StatsOperationsGet({
    required String? since,
    required String? until,
  }) {
    generatedMapping.putIfAbsent(OperationsResponse$Response,
        () => OperationsResponse$Response.fromJsonFactory);

    return _v1StatsOperationsGet(since: since, until: until);
  }

  ///
  ///@param since Time since the stats are requested (YYYY-MM-DDTHH:MM:SS)
  ///@param until Time until pool stats are requested (YYYY-MM-DDTHH:MM:SS)
  @Get(path: '/v1/stats/operations')
  Future<chopper.Response<OperationsResponse$Response>> _v1StatsOperationsGet({
    @Query('since') required String? since,
    @Query('until') required String? until,
  });

  ///
  ///@param since Time since the stats are requested (YYYY-MM-DDTHH:MM:SS)
  ///@param until Time until pool stats are requested (YYYY-MM-DDTHH:MM:SS)
  Future<chopper.Response<PoolStatsResponse$Response>> v1StatsPoolGet({
    required String? since,
    required String? until,
  }) {
    generatedMapping.putIfAbsent(PoolStatsResponse$Response,
        () => PoolStatsResponse$Response.fromJsonFactory);

    return _v1StatsPoolGet(since: since, until: until);
  }

  ///
  ///@param since Time since the stats are requested (YYYY-MM-DDTHH:MM:SS)
  ///@param until Time until pool stats are requested (YYYY-MM-DDTHH:MM:SS)
  @Get(path: '/v1/stats/pool')
  Future<chopper.Response<PoolStatsResponse$Response>> _v1StatsPoolGet({
    @Query('since') required String? since,
    @Query('until') required String? until,
  });

  ///
  ///@param offer_address The address of the token we want to sell
  ///@param ask_address The address of the token we want to buy
  ///@param units Number of token units we want to sell
  ///@param slippage_tolerance The maximum possible difference between the rates that we expect and which will actually be, in fractions (for example, 0.001 is 0.1%)
  ///@param referral_address Referral address
  Future<chopper.Response<SimulateSwapResponse$Response>> v1SwapSimulatePost({
    required String? offerAddress,
    required String? askAddress,
    required String? units,
    required String? slippageTolerance,
    String? referralAddress,
  }) {
    generatedMapping.putIfAbsent(SimulateSwapResponse$Response,
        () => SimulateSwapResponse$Response.fromJsonFactory);

    return _v1SwapSimulatePost(
        offerAddress: offerAddress,
        askAddress: askAddress,
        units: units,
        slippageTolerance: slippageTolerance,
        referralAddress: referralAddress);
  }

  ///
  ///@param offer_address The address of the token we want to sell
  ///@param ask_address The address of the token we want to buy
  ///@param units Number of token units we want to sell
  ///@param slippage_tolerance The maximum possible difference between the rates that we expect and which will actually be, in fractions (for example, 0.001 is 0.1%)
  ///@param referral_address Referral address
  @Post(
    path: '/v1/swap/simulate',
    optionalBody: true,
  )
  Future<chopper.Response<SimulateSwapResponse$Response>> _v1SwapSimulatePost({
    @Query('offer_address') required String? offerAddress,
    @Query('ask_address') required String? askAddress,
    @Query('units') required String? units,
    @Query('slippage_tolerance') required String? slippageTolerance,
    @Query('referral_address') String? referralAddress,
  });

  ///
  ///@param router_address Address of the operation router
  ///@param owner_address Owner`s wallet address
  ///@param query_id Id of operation status query
  Future<chopper.Response<Object>> v1SwapStatusGet({
    required String? routerAddress,
    required String? ownerAddress,
    required String? queryId,
  }) {
    return _v1SwapStatusGet(
        routerAddress: routerAddress,
        ownerAddress: ownerAddress,
        queryId: queryId);
  }

  ///
  ///@param router_address Address of the operation router
  ///@param owner_address Owner`s wallet address
  ///@param query_id Id of operation status query
  @Get(path: '/v1/swap/status')
  Future<chopper.Response<Object>> _v1SwapStatusGet({
    @Query('router_address') required String? routerAddress,
    @Query('owner_address') required String? ownerAddress,
    @Query('query_id') required String? queryId,
  });

  ///
  ///@param addr_str
  Future<chopper.Response<AssetListResponse$Response>>
      v1WalletsAddrStrAssetsGet({required String? addrStr}) {
    generatedMapping.putIfAbsent(AssetListResponse$Response,
        () => AssetListResponse$Response.fromJsonFactory);

    return _v1WalletsAddrStrAssetsGet(addrStr: addrStr);
  }

  ///
  ///@param addr_str
  @Get(path: '/v1/wallets/{addr_str}/assets')
  Future<chopper.Response<AssetListResponse$Response>>
      _v1WalletsAddrStrAssetsGet({@Path('addr_str') required String? addrStr});

  ///
  ///@param addr_str
  ///@param asset_str
  Future<chopper.Response<AssetResponse$Response>>
      v1WalletsAddrStrAssetsAssetStrGet({
    required String? addrStr,
    required String? assetStr,
  }) {
    generatedMapping.putIfAbsent(
        AssetResponse$Response, () => AssetResponse$Response.fromJsonFactory);

    return _v1WalletsAddrStrAssetsAssetStrGet(
        addrStr: addrStr, assetStr: assetStr);
  }

  ///
  ///@param addr_str
  ///@param asset_str
  @Get(path: '/v1/wallets/{addr_str}/assets/{asset_str}')
  Future<chopper.Response<AssetResponse$Response>>
      _v1WalletsAddrStrAssetsAssetStrGet({
    @Path('addr_str') required String? addrStr,
    @Path('asset_str') required String? assetStr,
  });

  ///
  ///@param addr_str
  Future<chopper.Response<FarmListResponse$Response>> v1WalletsAddrStrFarmsGet(
      {required String? addrStr}) {
    generatedMapping.putIfAbsent(FarmListResponse$Response,
        () => FarmListResponse$Response.fromJsonFactory);

    return _v1WalletsAddrStrFarmsGet(addrStr: addrStr);
  }

  ///
  ///@param addr_str
  @Get(path: '/v1/wallets/{addr_str}/farms')
  Future<chopper.Response<FarmListResponse$Response>> _v1WalletsAddrStrFarmsGet(
      {@Path('addr_str') required String? addrStr});

  ///
  ///@param addr_str
  ///@param farm_str
  Future<chopper.Response<FarmResponse$Response>>
      v1WalletsAddrStrFarmsFarmStrGet({
    required String? addrStr,
    required String? farmStr,
  }) {
    generatedMapping.putIfAbsent(
        FarmResponse$Response, () => FarmResponse$Response.fromJsonFactory);

    return _v1WalletsAddrStrFarmsFarmStrGet(addrStr: addrStr, farmStr: farmStr);
  }

  ///
  ///@param addr_str
  ///@param farm_str
  @Get(path: '/v1/wallets/{addr_str}/farms/{farm_str}')
  Future<chopper.Response<FarmResponse$Response>>
      _v1WalletsAddrStrFarmsFarmStrGet({
    @Path('addr_str') required String? addrStr,
    @Path('farm_str') required String? farmStr,
  });

  ///
  ///@param since Time since the stats are requested (YYYY-MM-DDTHH:MM:SS)
  ///@param until Time until pool stats are requested (YYYY-MM-DDTHH:MM:SS)
  ///@param op_type target op type
  ///@param addr_str
  Future<chopper.Response<OperationsResponse$Response>>
      v1WalletsAddrStrOperationsGet({
    required String? since,
    required String? until,
    String? opType,
    required String? addrStr,
  }) {
    generatedMapping.putIfAbsent(OperationsResponse$Response,
        () => OperationsResponse$Response.fromJsonFactory);

    return _v1WalletsAddrStrOperationsGet(
        since: since, until: until, opType: opType, addrStr: addrStr);
  }

  ///
  ///@param since Time since the stats are requested (YYYY-MM-DDTHH:MM:SS)
  ///@param until Time until pool stats are requested (YYYY-MM-DDTHH:MM:SS)
  ///@param op_type target op type
  ///@param addr_str
  @Get(path: '/v1/wallets/{addr_str}/operations')
  Future<chopper.Response<OperationsResponse$Response>>
      _v1WalletsAddrStrOperationsGet({
    @Query('since') required String? since,
    @Query('until') required String? until,
    @Query('op_type') String? opType,
    @Path('addr_str') required String? addrStr,
  });

  ///
  ///@param addr_str
  Future<chopper.Response<PoolListResponse$Response>> v1WalletsAddrStrPoolsGet(
      {required String? addrStr}) {
    generatedMapping.putIfAbsent(PoolListResponse$Response,
        () => PoolListResponse$Response.fromJsonFactory);

    return _v1WalletsAddrStrPoolsGet(addrStr: addrStr);
  }

  ///
  ///@param addr_str
  @Get(path: '/v1/wallets/{addr_str}/pools')
  Future<chopper.Response<PoolListResponse$Response>> _v1WalletsAddrStrPoolsGet(
      {@Path('addr_str') required String? addrStr});

  ///
  ///@param addr_str
  ///@param pool_str
  Future<chopper.Response<PoolResponse$Response>>
      v1WalletsAddrStrPoolsPoolStrGet({
    required String? addrStr,
    required String? poolStr,
  }) {
    generatedMapping.putIfAbsent(
        PoolResponse$Response, () => PoolResponse$Response.fromJsonFactory);

    return _v1WalletsAddrStrPoolsPoolStrGet(addrStr: addrStr, poolStr: poolStr);
  }

  ///
  ///@param addr_str
  ///@param pool_str
  @Get(path: '/v1/wallets/{addr_str}/pools/{pool_str}')
  Future<chopper.Response<PoolResponse$Response>>
      _v1WalletsAddrStrPoolsPoolStrGet({
    @Path('addr_str') required String? addrStr,
    @Path('pool_str') required String? poolStr,
  });
}

@JsonSerializable(explicitToJson: true)
class AssetInfoSchema {
  const AssetInfoSchema({
    this.balance,
    required this.blacklisted,
    required this.community,
    required this.contractAddress,
    required this.decimals,
    required this.defaultSymbol,
    required this.deprecated,
    this.dexPriceUsd,
    this.dexUsdPrice,
    this.displayName,
    this.imageUrl,
    required this.kind,
    required this.priority,
    required this.symbol,
    required this.tags,
    required this.taxable,
    this.thirdPartyPriceUsd,
    this.thirdPartyUsdPrice,
    this.walletAddress,
  });

  factory AssetInfoSchema.fromJson(Map<String, dynamic> json) =>
      _$AssetInfoSchemaFromJson(json);

  static const toJsonFactory = _$AssetInfoSchemaToJson;
  Map<String, dynamic> toJson() => _$AssetInfoSchemaToJson(this);

  @JsonKey(name: 'balance')
  final String? balance;
  @JsonKey(name: 'blacklisted')
  final bool blacklisted;
  @JsonKey(name: 'community')
  final bool community;
  @JsonKey(name: 'contract_address')
  final String contractAddress;
  @JsonKey(name: 'decimals')
  final int decimals;
  @JsonKey(name: 'default_symbol')
  final bool defaultSymbol;
  @JsonKey(name: 'deprecated')
  final bool deprecated;
  @JsonKey(name: 'dex_price_usd')
  final String? dexPriceUsd;
  @JsonKey(name: 'dex_usd_price')
  final String? dexUsdPrice;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(
    name: 'kind',
    toJson: assetKindSchemaToJson,
    fromJson: assetKindSchemaFromJson,
  )
  final enums.AssetKindSchema kind;
  @JsonKey(name: 'priority')
  final int priority;
  @JsonKey(name: 'symbol')
  final String symbol;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String> tags;
  @JsonKey(name: 'taxable')
  final bool taxable;
  @JsonKey(name: 'third_party_price_usd')
  final String? thirdPartyPriceUsd;
  @JsonKey(name: 'third_party_usd_price')
  final String? thirdPartyUsdPrice;
  @JsonKey(name: 'wallet_address')
  final String? walletAddress;
  static const fromJsonFactory = _$AssetInfoSchemaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssetInfoSchema &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality()
                    .equals(other.balance, balance)) &&
            (identical(other.blacklisted, blacklisted) ||
                const DeepCollectionEquality()
                    .equals(other.blacklisted, blacklisted)) &&
            (identical(other.community, community) ||
                const DeepCollectionEquality()
                    .equals(other.community, community)) &&
            (identical(other.contractAddress, contractAddress) ||
                const DeepCollectionEquality()
                    .equals(other.contractAddress, contractAddress)) &&
            (identical(other.decimals, decimals) ||
                const DeepCollectionEquality()
                    .equals(other.decimals, decimals)) &&
            (identical(other.defaultSymbol, defaultSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.defaultSymbol, defaultSymbol)) &&
            (identical(other.deprecated, deprecated) ||
                const DeepCollectionEquality()
                    .equals(other.deprecated, deprecated)) &&
            (identical(other.dexPriceUsd, dexPriceUsd) ||
                const DeepCollectionEquality()
                    .equals(other.dexPriceUsd, dexPriceUsd)) &&
            (identical(other.dexUsdPrice, dexUsdPrice) ||
                const DeepCollectionEquality()
                    .equals(other.dexUsdPrice, dexUsdPrice)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.kind, kind) ||
                const DeepCollectionEquality().equals(other.kind, kind)) &&
            (identical(other.priority, priority) ||
                const DeepCollectionEquality()
                    .equals(other.priority, priority)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.taxable, taxable) ||
                const DeepCollectionEquality()
                    .equals(other.taxable, taxable)) &&
            (identical(other.thirdPartyPriceUsd, thirdPartyPriceUsd) ||
                const DeepCollectionEquality()
                    .equals(other.thirdPartyPriceUsd, thirdPartyPriceUsd)) &&
            (identical(other.thirdPartyUsdPrice, thirdPartyUsdPrice) ||
                const DeepCollectionEquality()
                    .equals(other.thirdPartyUsdPrice, thirdPartyUsdPrice)) &&
            (identical(other.walletAddress, walletAddress) ||
                const DeepCollectionEquality()
                    .equals(other.walletAddress, walletAddress)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(blacklisted) ^
      const DeepCollectionEquality().hash(community) ^
      const DeepCollectionEquality().hash(contractAddress) ^
      const DeepCollectionEquality().hash(decimals) ^
      const DeepCollectionEquality().hash(defaultSymbol) ^
      const DeepCollectionEquality().hash(deprecated) ^
      const DeepCollectionEquality().hash(dexPriceUsd) ^
      const DeepCollectionEquality().hash(dexUsdPrice) ^
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(kind) ^
      const DeepCollectionEquality().hash(priority) ^
      const DeepCollectionEquality().hash(symbol) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(taxable) ^
      const DeepCollectionEquality().hash(thirdPartyPriceUsd) ^
      const DeepCollectionEquality().hash(thirdPartyUsdPrice) ^
      const DeepCollectionEquality().hash(walletAddress) ^
      runtimeType.hashCode;
}

extension $AssetInfoSchemaExtension on AssetInfoSchema {
  AssetInfoSchema copyWith(
      {String? balance,
      bool? blacklisted,
      bool? community,
      String? contractAddress,
      int? decimals,
      bool? defaultSymbol,
      bool? deprecated,
      String? dexPriceUsd,
      String? dexUsdPrice,
      String? displayName,
      String? imageUrl,
      enums.AssetKindSchema? kind,
      int? priority,
      String? symbol,
      List<String>? tags,
      bool? taxable,
      String? thirdPartyPriceUsd,
      String? thirdPartyUsdPrice,
      String? walletAddress}) {
    return AssetInfoSchema(
        balance: balance ?? this.balance,
        blacklisted: blacklisted ?? this.blacklisted,
        community: community ?? this.community,
        contractAddress: contractAddress ?? this.contractAddress,
        decimals: decimals ?? this.decimals,
        defaultSymbol: defaultSymbol ?? this.defaultSymbol,
        deprecated: deprecated ?? this.deprecated,
        dexPriceUsd: dexPriceUsd ?? this.dexPriceUsd,
        dexUsdPrice: dexUsdPrice ?? this.dexUsdPrice,
        displayName: displayName ?? this.displayName,
        imageUrl: imageUrl ?? this.imageUrl,
        kind: kind ?? this.kind,
        priority: priority ?? this.priority,
        symbol: symbol ?? this.symbol,
        tags: tags ?? this.tags,
        taxable: taxable ?? this.taxable,
        thirdPartyPriceUsd: thirdPartyPriceUsd ?? this.thirdPartyPriceUsd,
        thirdPartyUsdPrice: thirdPartyUsdPrice ?? this.thirdPartyUsdPrice,
        walletAddress: walletAddress ?? this.walletAddress);
  }

  AssetInfoSchema copyWithWrapped(
      {Wrapped<String?>? balance,
      Wrapped<bool>? blacklisted,
      Wrapped<bool>? community,
      Wrapped<String>? contractAddress,
      Wrapped<int>? decimals,
      Wrapped<bool>? defaultSymbol,
      Wrapped<bool>? deprecated,
      Wrapped<String?>? dexPriceUsd,
      Wrapped<String?>? dexUsdPrice,
      Wrapped<String?>? displayName,
      Wrapped<String?>? imageUrl,
      Wrapped<enums.AssetKindSchema>? kind,
      Wrapped<int>? priority,
      Wrapped<String>? symbol,
      Wrapped<List<String>>? tags,
      Wrapped<bool>? taxable,
      Wrapped<String?>? thirdPartyPriceUsd,
      Wrapped<String?>? thirdPartyUsdPrice,
      Wrapped<String?>? walletAddress}) {
    return AssetInfoSchema(
        balance: (balance != null ? balance.value : this.balance),
        blacklisted:
            (blacklisted != null ? blacklisted.value : this.blacklisted),
        community: (community != null ? community.value : this.community),
        contractAddress: (contractAddress != null
            ? contractAddress.value
            : this.contractAddress),
        decimals: (decimals != null ? decimals.value : this.decimals),
        defaultSymbol:
            (defaultSymbol != null ? defaultSymbol.value : this.defaultSymbol),
        deprecated: (deprecated != null ? deprecated.value : this.deprecated),
        dexPriceUsd:
            (dexPriceUsd != null ? dexPriceUsd.value : this.dexPriceUsd),
        dexUsdPrice:
            (dexUsdPrice != null ? dexUsdPrice.value : this.dexUsdPrice),
        displayName:
            (displayName != null ? displayName.value : this.displayName),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        kind: (kind != null ? kind.value : this.kind),
        priority: (priority != null ? priority.value : this.priority),
        symbol: (symbol != null ? symbol.value : this.symbol),
        tags: (tags != null ? tags.value : this.tags),
        taxable: (taxable != null ? taxable.value : this.taxable),
        thirdPartyPriceUsd: (thirdPartyPriceUsd != null
            ? thirdPartyPriceUsd.value
            : this.thirdPartyPriceUsd),
        thirdPartyUsdPrice: (thirdPartyUsdPrice != null
            ? thirdPartyUsdPrice.value
            : this.thirdPartyUsdPrice),
        walletAddress:
            (walletAddress != null ? walletAddress.value : this.walletAddress));
  }
}

@JsonSerializable(explicitToJson: true)
class AssetInfoSchemaV2 {
  const AssetInfoSchemaV2({
    this.balance,
    required this.contractAddress,
    this.dexPriceUsd,
    required this.kind,
    this.meta,
    this.pairPriority,
    this.tags,
    this.walletAddress,
  });

  factory AssetInfoSchemaV2.fromJson(Map<String, dynamic> json) =>
      _$AssetInfoSchemaV2FromJson(json);

  static const toJsonFactory = _$AssetInfoSchemaV2ToJson;
  Map<String, dynamic> toJson() => _$AssetInfoSchemaV2ToJson(this);

  @JsonKey(name: 'balance')
  final String? balance;
  @JsonKey(name: 'contract_address')
  final String contractAddress;
  @JsonKey(name: 'dex_price_usd')
  final String? dexPriceUsd;
  @JsonKey(
    name: 'kind',
    toJson: assetKindSchemaToJson,
    fromJson: assetKindSchemaFromJson,
  )
  final enums.AssetKindSchema kind;
  @JsonKey(name: 'meta')
  final AssetMetaSchemaV2? meta;
  @JsonKey(name: 'pair_priority')
  final int? pairPriority;
  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'wallet_address')
  final String? walletAddress;
  static const fromJsonFactory = _$AssetInfoSchemaV2FromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssetInfoSchemaV2 &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality()
                    .equals(other.balance, balance)) &&
            (identical(other.contractAddress, contractAddress) ||
                const DeepCollectionEquality()
                    .equals(other.contractAddress, contractAddress)) &&
            (identical(other.dexPriceUsd, dexPriceUsd) ||
                const DeepCollectionEquality()
                    .equals(other.dexPriceUsd, dexPriceUsd)) &&
            (identical(other.kind, kind) ||
                const DeepCollectionEquality().equals(other.kind, kind)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)) &&
            (identical(other.pairPriority, pairPriority) ||
                const DeepCollectionEquality()
                    .equals(other.pairPriority, pairPriority)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.walletAddress, walletAddress) ||
                const DeepCollectionEquality()
                    .equals(other.walletAddress, walletAddress)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(contractAddress) ^
      const DeepCollectionEquality().hash(dexPriceUsd) ^
      const DeepCollectionEquality().hash(kind) ^
      const DeepCollectionEquality().hash(meta) ^
      const DeepCollectionEquality().hash(pairPriority) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(walletAddress) ^
      runtimeType.hashCode;
}

extension $AssetInfoSchemaV2Extension on AssetInfoSchemaV2 {
  AssetInfoSchemaV2 copyWith(
      {String? balance,
      String? contractAddress,
      String? dexPriceUsd,
      enums.AssetKindSchema? kind,
      AssetMetaSchemaV2? meta,
      int? pairPriority,
      List<String>? tags,
      String? walletAddress}) {
    return AssetInfoSchemaV2(
        balance: balance ?? this.balance,
        contractAddress: contractAddress ?? this.contractAddress,
        dexPriceUsd: dexPriceUsd ?? this.dexPriceUsd,
        kind: kind ?? this.kind,
        meta: meta ?? this.meta,
        pairPriority: pairPriority ?? this.pairPriority,
        tags: tags ?? this.tags,
        walletAddress: walletAddress ?? this.walletAddress);
  }

  AssetInfoSchemaV2 copyWithWrapped(
      {Wrapped<String?>? balance,
      Wrapped<String>? contractAddress,
      Wrapped<String?>? dexPriceUsd,
      Wrapped<enums.AssetKindSchema>? kind,
      Wrapped<AssetMetaSchemaV2?>? meta,
      Wrapped<int?>? pairPriority,
      Wrapped<List<String>?>? tags,
      Wrapped<String?>? walletAddress}) {
    return AssetInfoSchemaV2(
        balance: (balance != null ? balance.value : this.balance),
        contractAddress: (contractAddress != null
            ? contractAddress.value
            : this.contractAddress),
        dexPriceUsd:
            (dexPriceUsd != null ? dexPriceUsd.value : this.dexPriceUsd),
        kind: (kind != null ? kind.value : this.kind),
        meta: (meta != null ? meta.value : this.meta),
        pairPriority:
            (pairPriority != null ? pairPriority.value : this.pairPriority),
        tags: (tags != null ? tags.value : this.tags),
        walletAddress:
            (walletAddress != null ? walletAddress.value : this.walletAddress));
  }
}

@JsonSerializable(explicitToJson: true)
class AssetInfoScreenerSchema {
  const AssetInfoScreenerSchema({
    this.circulatingSupply,
    required this.id,
    required this.name,
    required this.symbol,
    required this.totalSupply,
  });

  factory AssetInfoScreenerSchema.fromJson(Map<String, dynamic> json) =>
      _$AssetInfoScreenerSchemaFromJson(json);

  static const toJsonFactory = _$AssetInfoScreenerSchemaToJson;
  Map<String, dynamic> toJson() => _$AssetInfoScreenerSchemaToJson(this);

  @JsonKey(name: 'circulatingSupply')
  final String? circulatingSupply;
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'symbol')
  final String symbol;
  @JsonKey(name: 'totalSupply')
  final String totalSupply;
  static const fromJsonFactory = _$AssetInfoScreenerSchemaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssetInfoScreenerSchema &&
            (identical(other.circulatingSupply, circulatingSupply) ||
                const DeepCollectionEquality()
                    .equals(other.circulatingSupply, circulatingSupply)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)) &&
            (identical(other.totalSupply, totalSupply) ||
                const DeepCollectionEquality()
                    .equals(other.totalSupply, totalSupply)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(circulatingSupply) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(symbol) ^
      const DeepCollectionEquality().hash(totalSupply) ^
      runtimeType.hashCode;
}

extension $AssetInfoScreenerSchemaExtension on AssetInfoScreenerSchema {
  AssetInfoScreenerSchema copyWith(
      {String? circulatingSupply,
      String? id,
      String? name,
      String? symbol,
      String? totalSupply}) {
    return AssetInfoScreenerSchema(
        circulatingSupply: circulatingSupply ?? this.circulatingSupply,
        id: id ?? this.id,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        totalSupply: totalSupply ?? this.totalSupply);
  }

  AssetInfoScreenerSchema copyWithWrapped(
      {Wrapped<String?>? circulatingSupply,
      Wrapped<String>? id,
      Wrapped<String>? name,
      Wrapped<String>? symbol,
      Wrapped<String>? totalSupply}) {
    return AssetInfoScreenerSchema(
        circulatingSupply: (circulatingSupply != null
            ? circulatingSupply.value
            : this.circulatingSupply),
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        symbol: (symbol != null ? symbol.value : this.symbol),
        totalSupply:
            (totalSupply != null ? totalSupply.value : this.totalSupply));
  }
}

@JsonSerializable(explicitToJson: true)
class AssetMetaSchemaV2 {
  const AssetMetaSchemaV2({
    this.decimals,
    this.displayName,
    this.imageUrl,
    this.symbol,
  });

  factory AssetMetaSchemaV2.fromJson(Map<String, dynamic> json) =>
      _$AssetMetaSchemaV2FromJson(json);

  static const toJsonFactory = _$AssetMetaSchemaV2ToJson;
  Map<String, dynamic> toJson() => _$AssetMetaSchemaV2ToJson(this);

  @JsonKey(name: 'decimals')
  final int? decimals;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'symbol')
  final String? symbol;
  static const fromJsonFactory = _$AssetMetaSchemaV2FromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssetMetaSchemaV2 &&
            (identical(other.decimals, decimals) ||
                const DeepCollectionEquality()
                    .equals(other.decimals, decimals)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.symbol, symbol) ||
                const DeepCollectionEquality().equals(other.symbol, symbol)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(decimals) ^
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(symbol) ^
      runtimeType.hashCode;
}

extension $AssetMetaSchemaV2Extension on AssetMetaSchemaV2 {
  AssetMetaSchemaV2 copyWith(
      {int? decimals, String? displayName, String? imageUrl, String? symbol}) {
    return AssetMetaSchemaV2(
        decimals: decimals ?? this.decimals,
        displayName: displayName ?? this.displayName,
        imageUrl: imageUrl ?? this.imageUrl,
        symbol: symbol ?? this.symbol);
  }

  AssetMetaSchemaV2 copyWithWrapped(
      {Wrapped<int?>? decimals,
      Wrapped<String?>? displayName,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? symbol}) {
    return AssetMetaSchemaV2(
        decimals: (decimals != null ? decimals.value : this.decimals),
        displayName:
            (displayName != null ? displayName.value : this.displayName),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        symbol: (symbol != null ? symbol.value : this.symbol));
  }
}

@JsonSerializable(explicitToJson: true)
class BlockSchema {
  const BlockSchema({
    required this.blockNumber,
    required this.blockTimestamp,
  });

  factory BlockSchema.fromJson(Map<String, dynamic> json) =>
      _$BlockSchemaFromJson(json);

  static const toJsonFactory = _$BlockSchemaToJson;
  Map<String, dynamic> toJson() => _$BlockSchemaToJson(this);

  @JsonKey(name: 'blockNumber')
  final int blockNumber;
  @JsonKey(name: 'blockTimestamp')
  final int blockTimestamp;
  static const fromJsonFactory = _$BlockSchemaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BlockSchema &&
            (identical(other.blockNumber, blockNumber) ||
                const DeepCollectionEquality()
                    .equals(other.blockNumber, blockNumber)) &&
            (identical(other.blockTimestamp, blockTimestamp) ||
                const DeepCollectionEquality()
                    .equals(other.blockTimestamp, blockTimestamp)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(blockNumber) ^
      const DeepCollectionEquality().hash(blockTimestamp) ^
      runtimeType.hashCode;
}

extension $BlockSchemaExtension on BlockSchema {
  BlockSchema copyWith({int? blockNumber, int? blockTimestamp}) {
    return BlockSchema(
        blockNumber: blockNumber ?? this.blockNumber,
        blockTimestamp: blockTimestamp ?? this.blockTimestamp);
  }

  BlockSchema copyWithWrapped(
      {Wrapped<int>? blockNumber, Wrapped<int>? blockTimestamp}) {
    return BlockSchema(
        blockNumber:
            (blockNumber != null ? blockNumber.value : this.blockNumber),
        blockTimestamp: (blockTimestamp != null
            ? blockTimestamp.value
            : this.blockTimestamp));
  }
}

@JsonSerializable(explicitToJson: true)
class CmcPoolStats {
  const CmcPoolStats({
    required this.baseId,
    required this.baseLiquidity,
    required this.baseName,
    required this.baseSymbol,
    required this.baseVolume,
    required this.lastPrice,
    required this.quoteId,
    required this.quoteLiquidity,
    required this.quoteName,
    required this.quoteSymbol,
    required this.quoteVolume,
    required this.url,
  });

  factory CmcPoolStats.fromJson(Map<String, dynamic> json) =>
      _$CmcPoolStatsFromJson(json);

  static const toJsonFactory = _$CmcPoolStatsToJson;
  Map<String, dynamic> toJson() => _$CmcPoolStatsToJson(this);

  @JsonKey(name: 'base_id')
  final String baseId;
  @JsonKey(name: 'base_liquidity')
  final String baseLiquidity;
  @JsonKey(name: 'base_name')
  final String baseName;
  @JsonKey(name: 'base_symbol')
  final String baseSymbol;
  @JsonKey(name: 'base_volume')
  final String baseVolume;
  @JsonKey(name: 'last_price')
  final String lastPrice;
  @JsonKey(name: 'quote_id')
  final String quoteId;
  @JsonKey(name: 'quote_liquidity')
  final String quoteLiquidity;
  @JsonKey(name: 'quote_name')
  final String quoteName;
  @JsonKey(name: 'quote_symbol')
  final String quoteSymbol;
  @JsonKey(name: 'quote_volume')
  final String quoteVolume;
  @JsonKey(name: 'url')
  final String url;
  static const fromJsonFactory = _$CmcPoolStatsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CmcPoolStats &&
            (identical(other.baseId, baseId) ||
                const DeepCollectionEquality().equals(other.baseId, baseId)) &&
            (identical(other.baseLiquidity, baseLiquidity) ||
                const DeepCollectionEquality()
                    .equals(other.baseLiquidity, baseLiquidity)) &&
            (identical(other.baseName, baseName) ||
                const DeepCollectionEquality()
                    .equals(other.baseName, baseName)) &&
            (identical(other.baseSymbol, baseSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.baseSymbol, baseSymbol)) &&
            (identical(other.baseVolume, baseVolume) ||
                const DeepCollectionEquality()
                    .equals(other.baseVolume, baseVolume)) &&
            (identical(other.lastPrice, lastPrice) ||
                const DeepCollectionEquality()
                    .equals(other.lastPrice, lastPrice)) &&
            (identical(other.quoteId, quoteId) ||
                const DeepCollectionEquality()
                    .equals(other.quoteId, quoteId)) &&
            (identical(other.quoteLiquidity, quoteLiquidity) ||
                const DeepCollectionEquality()
                    .equals(other.quoteLiquidity, quoteLiquidity)) &&
            (identical(other.quoteName, quoteName) ||
                const DeepCollectionEquality()
                    .equals(other.quoteName, quoteName)) &&
            (identical(other.quoteSymbol, quoteSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.quoteSymbol, quoteSymbol)) &&
            (identical(other.quoteVolume, quoteVolume) ||
                const DeepCollectionEquality()
                    .equals(other.quoteVolume, quoteVolume)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(baseId) ^
      const DeepCollectionEquality().hash(baseLiquidity) ^
      const DeepCollectionEquality().hash(baseName) ^
      const DeepCollectionEquality().hash(baseSymbol) ^
      const DeepCollectionEquality().hash(baseVolume) ^
      const DeepCollectionEquality().hash(lastPrice) ^
      const DeepCollectionEquality().hash(quoteId) ^
      const DeepCollectionEquality().hash(quoteLiquidity) ^
      const DeepCollectionEquality().hash(quoteName) ^
      const DeepCollectionEquality().hash(quoteSymbol) ^
      const DeepCollectionEquality().hash(quoteVolume) ^
      const DeepCollectionEquality().hash(url) ^
      runtimeType.hashCode;
}

extension $CmcPoolStatsExtension on CmcPoolStats {
  CmcPoolStats copyWith(
      {String? baseId,
      String? baseLiquidity,
      String? baseName,
      String? baseSymbol,
      String? baseVolume,
      String? lastPrice,
      String? quoteId,
      String? quoteLiquidity,
      String? quoteName,
      String? quoteSymbol,
      String? quoteVolume,
      String? url}) {
    return CmcPoolStats(
        baseId: baseId ?? this.baseId,
        baseLiquidity: baseLiquidity ?? this.baseLiquidity,
        baseName: baseName ?? this.baseName,
        baseSymbol: baseSymbol ?? this.baseSymbol,
        baseVolume: baseVolume ?? this.baseVolume,
        lastPrice: lastPrice ?? this.lastPrice,
        quoteId: quoteId ?? this.quoteId,
        quoteLiquidity: quoteLiquidity ?? this.quoteLiquidity,
        quoteName: quoteName ?? this.quoteName,
        quoteSymbol: quoteSymbol ?? this.quoteSymbol,
        quoteVolume: quoteVolume ?? this.quoteVolume,
        url: url ?? this.url);
  }

  CmcPoolStats copyWithWrapped(
      {Wrapped<String>? baseId,
      Wrapped<String>? baseLiquidity,
      Wrapped<String>? baseName,
      Wrapped<String>? baseSymbol,
      Wrapped<String>? baseVolume,
      Wrapped<String>? lastPrice,
      Wrapped<String>? quoteId,
      Wrapped<String>? quoteLiquidity,
      Wrapped<String>? quoteName,
      Wrapped<String>? quoteSymbol,
      Wrapped<String>? quoteVolume,
      Wrapped<String>? url}) {
    return CmcPoolStats(
        baseId: (baseId != null ? baseId.value : this.baseId),
        baseLiquidity:
            (baseLiquidity != null ? baseLiquidity.value : this.baseLiquidity),
        baseName: (baseName != null ? baseName.value : this.baseName),
        baseSymbol: (baseSymbol != null ? baseSymbol.value : this.baseSymbol),
        baseVolume: (baseVolume != null ? baseVolume.value : this.baseVolume),
        lastPrice: (lastPrice != null ? lastPrice.value : this.lastPrice),
        quoteId: (quoteId != null ? quoteId.value : this.quoteId),
        quoteLiquidity: (quoteLiquidity != null
            ? quoteLiquidity.value
            : this.quoteLiquidity),
        quoteName: (quoteName != null ? quoteName.value : this.quoteName),
        quoteSymbol:
            (quoteSymbol != null ? quoteSymbol.value : this.quoteSymbol),
        quoteVolume:
            (quoteVolume != null ? quoteVolume.value : this.quoteVolume),
        url: (url != null ? url.value : this.url));
  }
}

@JsonSerializable(explicitToJson: true)
class DexStats {
  const DexStats({
    required this.trades,
    required this.tvl,
    required this.uniqueWallets,
    required this.volumeUsd,
  });

  factory DexStats.fromJson(Map<String, dynamic> json) =>
      _$DexStatsFromJson(json);

  static const toJsonFactory = _$DexStatsToJson;
  Map<String, dynamic> toJson() => _$DexStatsToJson(this);

  @JsonKey(name: 'trades')
  final int trades;
  @JsonKey(name: 'tvl')
  final String tvl;
  @JsonKey(name: 'unique_wallets')
  final int uniqueWallets;
  @JsonKey(name: 'volume_usd')
  final String volumeUsd;
  static const fromJsonFactory = _$DexStatsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DexStats &&
            (identical(other.trades, trades) ||
                const DeepCollectionEquality().equals(other.trades, trades)) &&
            (identical(other.tvl, tvl) ||
                const DeepCollectionEquality().equals(other.tvl, tvl)) &&
            (identical(other.uniqueWallets, uniqueWallets) ||
                const DeepCollectionEquality()
                    .equals(other.uniqueWallets, uniqueWallets)) &&
            (identical(other.volumeUsd, volumeUsd) ||
                const DeepCollectionEquality()
                    .equals(other.volumeUsd, volumeUsd)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(trades) ^
      const DeepCollectionEquality().hash(tvl) ^
      const DeepCollectionEquality().hash(uniqueWallets) ^
      const DeepCollectionEquality().hash(volumeUsd) ^
      runtimeType.hashCode;
}

extension $DexStatsExtension on DexStats {
  DexStats copyWith(
      {int? trades, String? tvl, int? uniqueWallets, String? volumeUsd}) {
    return DexStats(
        trades: trades ?? this.trades,
        tvl: tvl ?? this.tvl,
        uniqueWallets: uniqueWallets ?? this.uniqueWallets,
        volumeUsd: volumeUsd ?? this.volumeUsd);
  }

  DexStats copyWithWrapped(
      {Wrapped<int>? trades,
      Wrapped<String>? tvl,
      Wrapped<int>? uniqueWallets,
      Wrapped<String>? volumeUsd}) {
    return DexStats(
        trades: (trades != null ? trades.value : this.trades),
        tvl: (tvl != null ? tvl.value : this.tvl),
        uniqueWallets:
            (uniqueWallets != null ? uniqueWallets.value : this.uniqueWallets),
        volumeUsd: (volumeUsd != null ? volumeUsd.value : this.volumeUsd));
  }
}

@JsonSerializable(explicitToJson: true)
class EventSchema {
  const EventSchema({
    required this.block,
  });

  factory EventSchema.fromJson(Map<String, dynamic> json) =>
      _$EventSchemaFromJson(json);

  static const toJsonFactory = _$EventSchemaToJson;
  Map<String, dynamic> toJson() => _$EventSchemaToJson(this);

  @JsonKey(name: 'block')
  final BlockSchema block;
  static const fromJsonFactory = _$EventSchemaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EventSchema &&
            (identical(other.block, block) ||
                const DeepCollectionEquality().equals(other.block, block)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(block) ^ runtimeType.hashCode;
}

extension $EventSchemaExtension on EventSchema {
  EventSchema copyWith({BlockSchema? block}) {
    return EventSchema(block: block ?? this.block);
  }

  EventSchema copyWithWrapped({Wrapped<BlockSchema>? block}) {
    return EventSchema(block: (block != null ? block.value : this.block));
  }
}

@JsonSerializable(explicitToJson: true)
class EventType {
  const EventType();

  factory EventType.fromJson(Map<String, dynamic> json) =>
      _$EventTypeFromJson(json);

  static const toJsonFactory = _$EventTypeToJson;
  Map<String, dynamic> toJson() => _$EventTypeToJson(this);

  static const fromJsonFactory = _$EventTypeFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class FarmInfoSchema {
  const FarmInfoSchema({
    this.apy,
    required this.minStakeDurationS,
    required this.minterAddress,
    required this.nftInfos,
    required this.poolAddress,
    required this.rewardTokenAddress,
    required this.status,
  });

  factory FarmInfoSchema.fromJson(Map<String, dynamic> json) =>
      _$FarmInfoSchemaFromJson(json);

  static const toJsonFactory = _$FarmInfoSchemaToJson;
  Map<String, dynamic> toJson() => _$FarmInfoSchemaToJson(this);

  @JsonKey(name: 'apy')
  final String? apy;
  @JsonKey(name: 'min_stake_duration_s')
  final String minStakeDurationS;
  @JsonKey(name: 'minter_address')
  final String minterAddress;
  @JsonKey(name: 'nft_infos', defaultValue: <FarmNftInfoSchema>[])
  final List<FarmNftInfoSchema> nftInfos;
  @JsonKey(name: 'pool_address')
  final String poolAddress;
  @JsonKey(name: 'reward_token_address')
  final String rewardTokenAddress;
  @JsonKey(name: 'status')
  final String status;
  static const fromJsonFactory = _$FarmInfoSchemaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FarmInfoSchema &&
            (identical(other.apy, apy) ||
                const DeepCollectionEquality().equals(other.apy, apy)) &&
            (identical(other.minStakeDurationS, minStakeDurationS) ||
                const DeepCollectionEquality()
                    .equals(other.minStakeDurationS, minStakeDurationS)) &&
            (identical(other.minterAddress, minterAddress) ||
                const DeepCollectionEquality()
                    .equals(other.minterAddress, minterAddress)) &&
            (identical(other.nftInfos, nftInfos) ||
                const DeepCollectionEquality()
                    .equals(other.nftInfos, nftInfos)) &&
            (identical(other.poolAddress, poolAddress) ||
                const DeepCollectionEquality()
                    .equals(other.poolAddress, poolAddress)) &&
            (identical(other.rewardTokenAddress, rewardTokenAddress) ||
                const DeepCollectionEquality()
                    .equals(other.rewardTokenAddress, rewardTokenAddress)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(apy) ^
      const DeepCollectionEquality().hash(minStakeDurationS) ^
      const DeepCollectionEquality().hash(minterAddress) ^
      const DeepCollectionEquality().hash(nftInfos) ^
      const DeepCollectionEquality().hash(poolAddress) ^
      const DeepCollectionEquality().hash(rewardTokenAddress) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $FarmInfoSchemaExtension on FarmInfoSchema {
  FarmInfoSchema copyWith(
      {String? apy,
      String? minStakeDurationS,
      String? minterAddress,
      List<FarmNftInfoSchema>? nftInfos,
      String? poolAddress,
      String? rewardTokenAddress,
      String? status}) {
    return FarmInfoSchema(
        apy: apy ?? this.apy,
        minStakeDurationS: minStakeDurationS ?? this.minStakeDurationS,
        minterAddress: minterAddress ?? this.minterAddress,
        nftInfos: nftInfos ?? this.nftInfos,
        poolAddress: poolAddress ?? this.poolAddress,
        rewardTokenAddress: rewardTokenAddress ?? this.rewardTokenAddress,
        status: status ?? this.status);
  }

  FarmInfoSchema copyWithWrapped(
      {Wrapped<String?>? apy,
      Wrapped<String>? minStakeDurationS,
      Wrapped<String>? minterAddress,
      Wrapped<List<FarmNftInfoSchema>>? nftInfos,
      Wrapped<String>? poolAddress,
      Wrapped<String>? rewardTokenAddress,
      Wrapped<String>? status}) {
    return FarmInfoSchema(
        apy: (apy != null ? apy.value : this.apy),
        minStakeDurationS: (minStakeDurationS != null
            ? minStakeDurationS.value
            : this.minStakeDurationS),
        minterAddress:
            (minterAddress != null ? minterAddress.value : this.minterAddress),
        nftInfos: (nftInfos != null ? nftInfos.value : this.nftInfos),
        poolAddress:
            (poolAddress != null ? poolAddress.value : this.poolAddress),
        rewardTokenAddress: (rewardTokenAddress != null
            ? rewardTokenAddress.value
            : this.rewardTokenAddress),
        status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class FarmNftInfoSchema {
  const FarmNftInfoSchema({
    required this.address,
    required this.createTimestamp,
    required this.minUnstakeTimestamp,
    required this.nonclaimedRewards,
    required this.rewards,
    required this.stakedTokens,
    required this.status,
  });

  factory FarmNftInfoSchema.fromJson(Map<String, dynamic> json) =>
      _$FarmNftInfoSchemaFromJson(json);

  static const toJsonFactory = _$FarmNftInfoSchemaToJson;
  Map<String, dynamic> toJson() => _$FarmNftInfoSchemaToJson(this);

  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'create_timestamp')
  final String createTimestamp;
  @JsonKey(name: 'min_unstake_timestamp')
  final String minUnstakeTimestamp;
  @JsonKey(name: 'nonclaimed_rewards')
  final String nonclaimedRewards;
  @JsonKey(name: 'rewards', defaultValue: <FarmNftRewardInfoSchema>[])
  final List<FarmNftRewardInfoSchema> rewards;
  @JsonKey(name: 'staked_tokens')
  final String stakedTokens;
  @JsonKey(name: 'status')
  final String status;
  static const fromJsonFactory = _$FarmNftInfoSchemaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FarmNftInfoSchema &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.createTimestamp, createTimestamp) ||
                const DeepCollectionEquality()
                    .equals(other.createTimestamp, createTimestamp)) &&
            (identical(other.minUnstakeTimestamp, minUnstakeTimestamp) ||
                const DeepCollectionEquality()
                    .equals(other.minUnstakeTimestamp, minUnstakeTimestamp)) &&
            (identical(other.nonclaimedRewards, nonclaimedRewards) ||
                const DeepCollectionEquality()
                    .equals(other.nonclaimedRewards, nonclaimedRewards)) &&
            (identical(other.rewards, rewards) ||
                const DeepCollectionEquality()
                    .equals(other.rewards, rewards)) &&
            (identical(other.stakedTokens, stakedTokens) ||
                const DeepCollectionEquality()
                    .equals(other.stakedTokens, stakedTokens)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(createTimestamp) ^
      const DeepCollectionEquality().hash(minUnstakeTimestamp) ^
      const DeepCollectionEquality().hash(nonclaimedRewards) ^
      const DeepCollectionEquality().hash(rewards) ^
      const DeepCollectionEquality().hash(stakedTokens) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $FarmNftInfoSchemaExtension on FarmNftInfoSchema {
  FarmNftInfoSchema copyWith(
      {String? address,
      String? createTimestamp,
      String? minUnstakeTimestamp,
      String? nonclaimedRewards,
      List<FarmNftRewardInfoSchema>? rewards,
      String? stakedTokens,
      String? status}) {
    return FarmNftInfoSchema(
        address: address ?? this.address,
        createTimestamp: createTimestamp ?? this.createTimestamp,
        minUnstakeTimestamp: minUnstakeTimestamp ?? this.minUnstakeTimestamp,
        nonclaimedRewards: nonclaimedRewards ?? this.nonclaimedRewards,
        rewards: rewards ?? this.rewards,
        stakedTokens: stakedTokens ?? this.stakedTokens,
        status: status ?? this.status);
  }

  FarmNftInfoSchema copyWithWrapped(
      {Wrapped<String>? address,
      Wrapped<String>? createTimestamp,
      Wrapped<String>? minUnstakeTimestamp,
      Wrapped<String>? nonclaimedRewards,
      Wrapped<List<FarmNftRewardInfoSchema>>? rewards,
      Wrapped<String>? stakedTokens,
      Wrapped<String>? status}) {
    return FarmNftInfoSchema(
        address: (address != null ? address.value : this.address),
        createTimestamp: (createTimestamp != null
            ? createTimestamp.value
            : this.createTimestamp),
        minUnstakeTimestamp: (minUnstakeTimestamp != null
            ? minUnstakeTimestamp.value
            : this.minUnstakeTimestamp),
        nonclaimedRewards: (nonclaimedRewards != null
            ? nonclaimedRewards.value
            : this.nonclaimedRewards),
        rewards: (rewards != null ? rewards.value : this.rewards),
        stakedTokens:
            (stakedTokens != null ? stakedTokens.value : this.stakedTokens),
        status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class FarmNftRewardInfoSchema {
  const FarmNftRewardInfoSchema({
    required this.address,
    required this.amount,
  });

  factory FarmNftRewardInfoSchema.fromJson(Map<String, dynamic> json) =>
      _$FarmNftRewardInfoSchemaFromJson(json);

  static const toJsonFactory = _$FarmNftRewardInfoSchemaToJson;
  Map<String, dynamic> toJson() => _$FarmNftRewardInfoSchemaToJson(this);

  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'amount')
  final String amount;
  static const fromJsonFactory = _$FarmNftRewardInfoSchemaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FarmNftRewardInfoSchema &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(amount) ^
      runtimeType.hashCode;
}

extension $FarmNftRewardInfoSchemaExtension on FarmNftRewardInfoSchema {
  FarmNftRewardInfoSchema copyWith({String? address, String? amount}) {
    return FarmNftRewardInfoSchema(
        address: address ?? this.address, amount: amount ?? this.amount);
  }

  FarmNftRewardInfoSchema copyWithWrapped(
      {Wrapped<String>? address, Wrapped<String>? amount}) {
    return FarmNftRewardInfoSchema(
        address: (address != null ? address.value : this.address),
        amount: (amount != null ? amount.value : this.amount));
  }
}

@JsonSerializable(explicitToJson: true)
class LiquidityEvent {
  const LiquidityEvent({
    required this.amount0,
    required this.amount1,
    required this.eventIndex,
    required this.maker,
    required this.pairId,
    this.reserves,
    required this.txnId,
    required this.txnIndex,
  });

  factory LiquidityEvent.fromJson(Map<String, dynamic> json) =>
      _$LiquidityEventFromJson(json);

  static const toJsonFactory = _$LiquidityEventToJson;
  Map<String, dynamic> toJson() => _$LiquidityEventToJson(this);

  @JsonKey(name: 'amount0')
  final String amount0;
  @JsonKey(name: 'amount1')
  final String amount1;
  @JsonKey(name: 'eventIndex')
  final int eventIndex;
  @JsonKey(name: 'maker')
  final String maker;
  @JsonKey(name: 'pairId')
  final String pairId;
  @JsonKey(name: 'reserves')
  final Reserves? reserves;
  @JsonKey(name: 'txnId')
  final String txnId;
  @JsonKey(name: 'txnIndex')
  final int txnIndex;
  static const fromJsonFactory = _$LiquidityEventFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LiquidityEvent &&
            (identical(other.amount0, amount0) ||
                const DeepCollectionEquality()
                    .equals(other.amount0, amount0)) &&
            (identical(other.amount1, amount1) ||
                const DeepCollectionEquality()
                    .equals(other.amount1, amount1)) &&
            (identical(other.eventIndex, eventIndex) ||
                const DeepCollectionEquality()
                    .equals(other.eventIndex, eventIndex)) &&
            (identical(other.maker, maker) ||
                const DeepCollectionEquality().equals(other.maker, maker)) &&
            (identical(other.pairId, pairId) ||
                const DeepCollectionEquality().equals(other.pairId, pairId)) &&
            (identical(other.reserves, reserves) ||
                const DeepCollectionEquality()
                    .equals(other.reserves, reserves)) &&
            (identical(other.txnId, txnId) ||
                const DeepCollectionEquality().equals(other.txnId, txnId)) &&
            (identical(other.txnIndex, txnIndex) ||
                const DeepCollectionEquality()
                    .equals(other.txnIndex, txnIndex)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(amount0) ^
      const DeepCollectionEquality().hash(amount1) ^
      const DeepCollectionEquality().hash(eventIndex) ^
      const DeepCollectionEquality().hash(maker) ^
      const DeepCollectionEquality().hash(pairId) ^
      const DeepCollectionEquality().hash(reserves) ^
      const DeepCollectionEquality().hash(txnId) ^
      const DeepCollectionEquality().hash(txnIndex) ^
      runtimeType.hashCode;
}

extension $LiquidityEventExtension on LiquidityEvent {
  LiquidityEvent copyWith(
      {String? amount0,
      String? amount1,
      int? eventIndex,
      String? maker,
      String? pairId,
      Reserves? reserves,
      String? txnId,
      int? txnIndex}) {
    return LiquidityEvent(
        amount0: amount0 ?? this.amount0,
        amount1: amount1 ?? this.amount1,
        eventIndex: eventIndex ?? this.eventIndex,
        maker: maker ?? this.maker,
        pairId: pairId ?? this.pairId,
        reserves: reserves ?? this.reserves,
        txnId: txnId ?? this.txnId,
        txnIndex: txnIndex ?? this.txnIndex);
  }

  LiquidityEvent copyWithWrapped(
      {Wrapped<String>? amount0,
      Wrapped<String>? amount1,
      Wrapped<int>? eventIndex,
      Wrapped<String>? maker,
      Wrapped<String>? pairId,
      Wrapped<Reserves?>? reserves,
      Wrapped<String>? txnId,
      Wrapped<int>? txnIndex}) {
    return LiquidityEvent(
        amount0: (amount0 != null ? amount0.value : this.amount0),
        amount1: (amount1 != null ? amount1.value : this.amount1),
        eventIndex: (eventIndex != null ? eventIndex.value : this.eventIndex),
        maker: (maker != null ? maker.value : this.maker),
        pairId: (pairId != null ? pairId.value : this.pairId),
        reserves: (reserves != null ? reserves.value : this.reserves),
        txnId: (txnId != null ? txnId.value : this.txnId),
        txnIndex: (txnIndex != null ? txnIndex.value : this.txnIndex));
  }
}

@JsonSerializable(explicitToJson: true)
class OperationStat {
  const OperationStat({
    required this.asset0Address,
    required this.asset0Amount,
    required this.asset0Delta,
    required this.asset0Reserve,
    required this.asset1Address,
    required this.asset1Amount,
    required this.asset1Delta,
    required this.asset1Reserve,
    required this.destinationWalletAddress,
    required this.exitCode,
    this.feeAssetAddress,
    required this.lpFeeAmount,
    required this.lpTokenDelta,
    required this.lpTokenSupply,
    required this.operationType,
    required this.poolAddress,
    required this.poolTxHash,
    required this.poolTxLt,
    required this.poolTxTimestamp,
    required this.protocolFeeAmount,
    this.referralAddress,
    required this.referralFeeAmount,
    required this.routerAddress,
    required this.success,
    required this.walletAddress,
    required this.walletTxHash,
    required this.walletTxLt,
    required this.walletTxTimestamp,
  });

  factory OperationStat.fromJson(Map<String, dynamic> json) =>
      _$OperationStatFromJson(json);

  static const toJsonFactory = _$OperationStatToJson;
  Map<String, dynamic> toJson() => _$OperationStatToJson(this);

  @JsonKey(name: 'asset0_address')
  final String asset0Address;
  @JsonKey(name: 'asset0_amount')
  final String asset0Amount;
  @JsonKey(name: 'asset0_delta')
  final String asset0Delta;
  @JsonKey(name: 'asset0_reserve')
  final String asset0Reserve;
  @JsonKey(name: 'asset1_address')
  final String asset1Address;
  @JsonKey(name: 'asset1_amount')
  final String asset1Amount;
  @JsonKey(name: 'asset1_delta')
  final String asset1Delta;
  @JsonKey(name: 'asset1_reserve')
  final String asset1Reserve;
  @JsonKey(name: 'destination_wallet_address')
  final String destinationWalletAddress;
  @JsonKey(name: 'exit_code')
  final String exitCode;
  @JsonKey(name: 'fee_asset_address')
  final String? feeAssetAddress;
  @JsonKey(name: 'lp_fee_amount')
  final String lpFeeAmount;
  @JsonKey(name: 'lp_token_delta')
  final String lpTokenDelta;
  @JsonKey(name: 'lp_token_supply')
  final String lpTokenSupply;
  @JsonKey(name: 'operation_type')
  final String operationType;
  @JsonKey(name: 'pool_address')
  final String poolAddress;
  @JsonKey(name: 'pool_tx_hash')
  final String poolTxHash;
  @JsonKey(name: 'pool_tx_lt')
  final int poolTxLt;
  @JsonKey(name: 'pool_tx_timestamp')
  final String poolTxTimestamp;
  @JsonKey(name: 'protocol_fee_amount')
  final String protocolFeeAmount;
  @JsonKey(name: 'referral_address')
  final String? referralAddress;
  @JsonKey(name: 'referral_fee_amount')
  final String referralFeeAmount;
  @JsonKey(name: 'router_address')
  final String routerAddress;
  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'wallet_address')
  final String walletAddress;
  @JsonKey(name: 'wallet_tx_hash')
  final String walletTxHash;
  @JsonKey(name: 'wallet_tx_lt')
  final String walletTxLt;
  @JsonKey(name: 'wallet_tx_timestamp')
  final String walletTxTimestamp;
  static const fromJsonFactory = _$OperationStatFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OperationStat &&
            (identical(other.asset0Address, asset0Address) ||
                const DeepCollectionEquality()
                    .equals(other.asset0Address, asset0Address)) &&
            (identical(other.asset0Amount, asset0Amount) ||
                const DeepCollectionEquality()
                    .equals(other.asset0Amount, asset0Amount)) &&
            (identical(other.asset0Delta, asset0Delta) ||
                const DeepCollectionEquality()
                    .equals(other.asset0Delta, asset0Delta)) &&
            (identical(other.asset0Reserve, asset0Reserve) ||
                const DeepCollectionEquality()
                    .equals(other.asset0Reserve, asset0Reserve)) &&
            (identical(other.asset1Address, asset1Address) ||
                const DeepCollectionEquality()
                    .equals(other.asset1Address, asset1Address)) &&
            (identical(other.asset1Amount, asset1Amount) ||
                const DeepCollectionEquality()
                    .equals(other.asset1Amount, asset1Amount)) &&
            (identical(other.asset1Delta, asset1Delta) ||
                const DeepCollectionEquality()
                    .equals(other.asset1Delta, asset1Delta)) &&
            (identical(other.asset1Reserve, asset1Reserve) ||
                const DeepCollectionEquality()
                    .equals(other.asset1Reserve, asset1Reserve)) &&
            (identical(other.destinationWalletAddress, destinationWalletAddress) ||
                const DeepCollectionEquality().equals(
                    other.destinationWalletAddress,
                    destinationWalletAddress)) &&
            (identical(other.exitCode, exitCode) ||
                const DeepCollectionEquality()
                    .equals(other.exitCode, exitCode)) &&
            (identical(other.feeAssetAddress, feeAssetAddress) ||
                const DeepCollectionEquality()
                    .equals(other.feeAssetAddress, feeAssetAddress)) &&
            (identical(other.lpFeeAmount, lpFeeAmount) ||
                const DeepCollectionEquality()
                    .equals(other.lpFeeAmount, lpFeeAmount)) &&
            (identical(other.lpTokenDelta, lpTokenDelta) ||
                const DeepCollectionEquality()
                    .equals(other.lpTokenDelta, lpTokenDelta)) &&
            (identical(other.lpTokenSupply, lpTokenSupply) ||
                const DeepCollectionEquality()
                    .equals(other.lpTokenSupply, lpTokenSupply)) &&
            (identical(other.operationType, operationType) ||
                const DeepCollectionEquality()
                    .equals(other.operationType, operationType)) &&
            (identical(other.poolAddress, poolAddress) ||
                const DeepCollectionEquality()
                    .equals(other.poolAddress, poolAddress)) &&
            (identical(other.poolTxHash, poolTxHash) ||
                const DeepCollectionEquality()
                    .equals(other.poolTxHash, poolTxHash)) &&
            (identical(other.poolTxLt, poolTxLt) ||
                const DeepCollectionEquality()
                    .equals(other.poolTxLt, poolTxLt)) &&
            (identical(other.poolTxTimestamp, poolTxTimestamp) ||
                const DeepCollectionEquality().equals(other.poolTxTimestamp, poolTxTimestamp)) &&
            (identical(other.protocolFeeAmount, protocolFeeAmount) || const DeepCollectionEquality().equals(other.protocolFeeAmount, protocolFeeAmount)) &&
            (identical(other.referralAddress, referralAddress) || const DeepCollectionEquality().equals(other.referralAddress, referralAddress)) &&
            (identical(other.referralFeeAmount, referralFeeAmount) || const DeepCollectionEquality().equals(other.referralFeeAmount, referralFeeAmount)) &&
            (identical(other.routerAddress, routerAddress) || const DeepCollectionEquality().equals(other.routerAddress, routerAddress)) &&
            (identical(other.success, success) || const DeepCollectionEquality().equals(other.success, success)) &&
            (identical(other.walletAddress, walletAddress) || const DeepCollectionEquality().equals(other.walletAddress, walletAddress)) &&
            (identical(other.walletTxHash, walletTxHash) || const DeepCollectionEquality().equals(other.walletTxHash, walletTxHash)) &&
            (identical(other.walletTxLt, walletTxLt) || const DeepCollectionEquality().equals(other.walletTxLt, walletTxLt)) &&
            (identical(other.walletTxTimestamp, walletTxTimestamp) || const DeepCollectionEquality().equals(other.walletTxTimestamp, walletTxTimestamp)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(asset0Address) ^
      const DeepCollectionEquality().hash(asset0Amount) ^
      const DeepCollectionEquality().hash(asset0Delta) ^
      const DeepCollectionEquality().hash(asset0Reserve) ^
      const DeepCollectionEquality().hash(asset1Address) ^
      const DeepCollectionEquality().hash(asset1Amount) ^
      const DeepCollectionEquality().hash(asset1Delta) ^
      const DeepCollectionEquality().hash(asset1Reserve) ^
      const DeepCollectionEquality().hash(destinationWalletAddress) ^
      const DeepCollectionEquality().hash(exitCode) ^
      const DeepCollectionEquality().hash(feeAssetAddress) ^
      const DeepCollectionEquality().hash(lpFeeAmount) ^
      const DeepCollectionEquality().hash(lpTokenDelta) ^
      const DeepCollectionEquality().hash(lpTokenSupply) ^
      const DeepCollectionEquality().hash(operationType) ^
      const DeepCollectionEquality().hash(poolAddress) ^
      const DeepCollectionEquality().hash(poolTxHash) ^
      const DeepCollectionEquality().hash(poolTxLt) ^
      const DeepCollectionEquality().hash(poolTxTimestamp) ^
      const DeepCollectionEquality().hash(protocolFeeAmount) ^
      const DeepCollectionEquality().hash(referralAddress) ^
      const DeepCollectionEquality().hash(referralFeeAmount) ^
      const DeepCollectionEquality().hash(routerAddress) ^
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(walletAddress) ^
      const DeepCollectionEquality().hash(walletTxHash) ^
      const DeepCollectionEquality().hash(walletTxLt) ^
      const DeepCollectionEquality().hash(walletTxTimestamp) ^
      runtimeType.hashCode;
}

extension $OperationStatExtension on OperationStat {
  OperationStat copyWith(
      {String? asset0Address,
      String? asset0Amount,
      String? asset0Delta,
      String? asset0Reserve,
      String? asset1Address,
      String? asset1Amount,
      String? asset1Delta,
      String? asset1Reserve,
      String? destinationWalletAddress,
      String? exitCode,
      String? feeAssetAddress,
      String? lpFeeAmount,
      String? lpTokenDelta,
      String? lpTokenSupply,
      String? operationType,
      String? poolAddress,
      String? poolTxHash,
      int? poolTxLt,
      String? poolTxTimestamp,
      String? protocolFeeAmount,
      String? referralAddress,
      String? referralFeeAmount,
      String? routerAddress,
      bool? success,
      String? walletAddress,
      String? walletTxHash,
      String? walletTxLt,
      String? walletTxTimestamp}) {
    return OperationStat(
        asset0Address: asset0Address ?? this.asset0Address,
        asset0Amount: asset0Amount ?? this.asset0Amount,
        asset0Delta: asset0Delta ?? this.asset0Delta,
        asset0Reserve: asset0Reserve ?? this.asset0Reserve,
        asset1Address: asset1Address ?? this.asset1Address,
        asset1Amount: asset1Amount ?? this.asset1Amount,
        asset1Delta: asset1Delta ?? this.asset1Delta,
        asset1Reserve: asset1Reserve ?? this.asset1Reserve,
        destinationWalletAddress:
            destinationWalletAddress ?? this.destinationWalletAddress,
        exitCode: exitCode ?? this.exitCode,
        feeAssetAddress: feeAssetAddress ?? this.feeAssetAddress,
        lpFeeAmount: lpFeeAmount ?? this.lpFeeAmount,
        lpTokenDelta: lpTokenDelta ?? this.lpTokenDelta,
        lpTokenSupply: lpTokenSupply ?? this.lpTokenSupply,
        operationType: operationType ?? this.operationType,
        poolAddress: poolAddress ?? this.poolAddress,
        poolTxHash: poolTxHash ?? this.poolTxHash,
        poolTxLt: poolTxLt ?? this.poolTxLt,
        poolTxTimestamp: poolTxTimestamp ?? this.poolTxTimestamp,
        protocolFeeAmount: protocolFeeAmount ?? this.protocolFeeAmount,
        referralAddress: referralAddress ?? this.referralAddress,
        referralFeeAmount: referralFeeAmount ?? this.referralFeeAmount,
        routerAddress: routerAddress ?? this.routerAddress,
        success: success ?? this.success,
        walletAddress: walletAddress ?? this.walletAddress,
        walletTxHash: walletTxHash ?? this.walletTxHash,
        walletTxLt: walletTxLt ?? this.walletTxLt,
        walletTxTimestamp: walletTxTimestamp ?? this.walletTxTimestamp);
  }

  OperationStat copyWithWrapped(
      {Wrapped<String>? asset0Address,
      Wrapped<String>? asset0Amount,
      Wrapped<String>? asset0Delta,
      Wrapped<String>? asset0Reserve,
      Wrapped<String>? asset1Address,
      Wrapped<String>? asset1Amount,
      Wrapped<String>? asset1Delta,
      Wrapped<String>? asset1Reserve,
      Wrapped<String>? destinationWalletAddress,
      Wrapped<String>? exitCode,
      Wrapped<String?>? feeAssetAddress,
      Wrapped<String>? lpFeeAmount,
      Wrapped<String>? lpTokenDelta,
      Wrapped<String>? lpTokenSupply,
      Wrapped<String>? operationType,
      Wrapped<String>? poolAddress,
      Wrapped<String>? poolTxHash,
      Wrapped<int>? poolTxLt,
      Wrapped<String>? poolTxTimestamp,
      Wrapped<String>? protocolFeeAmount,
      Wrapped<String?>? referralAddress,
      Wrapped<String>? referralFeeAmount,
      Wrapped<String>? routerAddress,
      Wrapped<bool>? success,
      Wrapped<String>? walletAddress,
      Wrapped<String>? walletTxHash,
      Wrapped<String>? walletTxLt,
      Wrapped<String>? walletTxTimestamp}) {
    return OperationStat(
        asset0Address:
            (asset0Address != null ? asset0Address.value : this.asset0Address),
        asset0Amount:
            (asset0Amount != null ? asset0Amount.value : this.asset0Amount),
        asset0Delta:
            (asset0Delta != null ? asset0Delta.value : this.asset0Delta),
        asset0Reserve:
            (asset0Reserve != null ? asset0Reserve.value : this.asset0Reserve),
        asset1Address:
            (asset1Address != null ? asset1Address.value : this.asset1Address),
        asset1Amount:
            (asset1Amount != null ? asset1Amount.value : this.asset1Amount),
        asset1Delta:
            (asset1Delta != null ? asset1Delta.value : this.asset1Delta),
        asset1Reserve:
            (asset1Reserve != null ? asset1Reserve.value : this.asset1Reserve),
        destinationWalletAddress: (destinationWalletAddress != null
            ? destinationWalletAddress.value
            : this.destinationWalletAddress),
        exitCode: (exitCode != null ? exitCode.value : this.exitCode),
        feeAssetAddress: (feeAssetAddress != null
            ? feeAssetAddress.value
            : this.feeAssetAddress),
        lpFeeAmount:
            (lpFeeAmount != null ? lpFeeAmount.value : this.lpFeeAmount),
        lpTokenDelta:
            (lpTokenDelta != null ? lpTokenDelta.value : this.lpTokenDelta),
        lpTokenSupply:
            (lpTokenSupply != null ? lpTokenSupply.value : this.lpTokenSupply),
        operationType:
            (operationType != null ? operationType.value : this.operationType),
        poolAddress:
            (poolAddress != null ? poolAddress.value : this.poolAddress),
        poolTxHash: (poolTxHash != null ? poolTxHash.value : this.poolTxHash),
        poolTxLt: (poolTxLt != null ? poolTxLt.value : this.poolTxLt),
        poolTxTimestamp: (poolTxTimestamp != null
            ? poolTxTimestamp.value
            : this.poolTxTimestamp),
        protocolFeeAmount: (protocolFeeAmount != null
            ? protocolFeeAmount.value
            : this.protocolFeeAmount),
        referralAddress: (referralAddress != null
            ? referralAddress.value
            : this.referralAddress),
        referralFeeAmount: (referralFeeAmount != null
            ? referralFeeAmount.value
            : this.referralFeeAmount),
        routerAddress:
            (routerAddress != null ? routerAddress.value : this.routerAddress),
        success: (success != null ? success.value : this.success),
        walletAddress:
            (walletAddress != null ? walletAddress.value : this.walletAddress),
        walletTxHash:
            (walletTxHash != null ? walletTxHash.value : this.walletTxHash),
        walletTxLt: (walletTxLt != null ? walletTxLt.value : this.walletTxLt),
        walletTxTimestamp: (walletTxTimestamp != null
            ? walletTxTimestamp.value
            : this.walletTxTimestamp));
  }
}

@JsonSerializable(explicitToJson: true)
class OperationStatus {
  const OperationStatus({
    required this.address,
    required this.balanceDeltas,
    required this.coins,
    required this.exitCode,
    required this.logicalTime,
    required this.queryId,
    required this.txHash,
  });

  factory OperationStatus.fromJson(Map<String, dynamic> json) =>
      _$OperationStatusFromJson(json);

  static const toJsonFactory = _$OperationStatusToJson;
  Map<String, dynamic> toJson() => _$OperationStatusToJson(this);

  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'balance_deltas')
  final String balanceDeltas;
  @JsonKey(name: 'coins')
  final String coins;
  @JsonKey(name: 'exit_code')
  final String exitCode;
  @JsonKey(name: 'logical_time')
  final String logicalTime;
  @JsonKey(name: 'query_id')
  final String queryId;
  @JsonKey(name: 'tx_hash')
  final String txHash;
  static const fromJsonFactory = _$OperationStatusFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OperationStatus &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.balanceDeltas, balanceDeltas) ||
                const DeepCollectionEquality()
                    .equals(other.balanceDeltas, balanceDeltas)) &&
            (identical(other.coins, coins) ||
                const DeepCollectionEquality().equals(other.coins, coins)) &&
            (identical(other.exitCode, exitCode) ||
                const DeepCollectionEquality()
                    .equals(other.exitCode, exitCode)) &&
            (identical(other.logicalTime, logicalTime) ||
                const DeepCollectionEquality()
                    .equals(other.logicalTime, logicalTime)) &&
            (identical(other.queryId, queryId) ||
                const DeepCollectionEquality()
                    .equals(other.queryId, queryId)) &&
            (identical(other.txHash, txHash) ||
                const DeepCollectionEquality().equals(other.txHash, txHash)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(balanceDeltas) ^
      const DeepCollectionEquality().hash(coins) ^
      const DeepCollectionEquality().hash(exitCode) ^
      const DeepCollectionEquality().hash(logicalTime) ^
      const DeepCollectionEquality().hash(queryId) ^
      const DeepCollectionEquality().hash(txHash) ^
      runtimeType.hashCode;
}

extension $OperationStatusExtension on OperationStatus {
  OperationStatus copyWith(
      {String? address,
      String? balanceDeltas,
      String? coins,
      String? exitCode,
      String? logicalTime,
      String? queryId,
      String? txHash}) {
    return OperationStatus(
        address: address ?? this.address,
        balanceDeltas: balanceDeltas ?? this.balanceDeltas,
        coins: coins ?? this.coins,
        exitCode: exitCode ?? this.exitCode,
        logicalTime: logicalTime ?? this.logicalTime,
        queryId: queryId ?? this.queryId,
        txHash: txHash ?? this.txHash);
  }

  OperationStatus copyWithWrapped(
      {Wrapped<String>? address,
      Wrapped<String>? balanceDeltas,
      Wrapped<String>? coins,
      Wrapped<String>? exitCode,
      Wrapped<String>? logicalTime,
      Wrapped<String>? queryId,
      Wrapped<String>? txHash}) {
    return OperationStatus(
        address: (address != null ? address.value : this.address),
        balanceDeltas:
            (balanceDeltas != null ? balanceDeltas.value : this.balanceDeltas),
        coins: (coins != null ? coins.value : this.coins),
        exitCode: (exitCode != null ? exitCode.value : this.exitCode),
        logicalTime:
            (logicalTime != null ? logicalTime.value : this.logicalTime),
        queryId: (queryId != null ? queryId.value : this.queryId),
        txHash: (txHash != null ? txHash.value : this.txHash));
  }
}

@JsonSerializable(explicitToJson: true)
class OperationsInfo {
  const OperationsInfo({
    required this.asset0Info,
    required this.asset1Info,
    required this.operation,
  });

  factory OperationsInfo.fromJson(Map<String, dynamic> json) =>
      _$OperationsInfoFromJson(json);

  static const toJsonFactory = _$OperationsInfoToJson;
  Map<String, dynamic> toJson() => _$OperationsInfoToJson(this);

  @JsonKey(name: 'asset0_info')
  final AssetInfoSchema asset0Info;
  @JsonKey(name: 'asset1_info')
  final AssetInfoSchema asset1Info;
  @JsonKey(name: 'operation')
  final OperationStat operation;
  static const fromJsonFactory = _$OperationsInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OperationsInfo &&
            (identical(other.asset0Info, asset0Info) ||
                const DeepCollectionEquality()
                    .equals(other.asset0Info, asset0Info)) &&
            (identical(other.asset1Info, asset1Info) ||
                const DeepCollectionEquality()
                    .equals(other.asset1Info, asset1Info)) &&
            (identical(other.operation, operation) ||
                const DeepCollectionEquality()
                    .equals(other.operation, operation)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(asset0Info) ^
      const DeepCollectionEquality().hash(asset1Info) ^
      const DeepCollectionEquality().hash(operation) ^
      runtimeType.hashCode;
}

extension $OperationsInfoExtension on OperationsInfo {
  OperationsInfo copyWith(
      {AssetInfoSchema? asset0Info,
      AssetInfoSchema? asset1Info,
      OperationStat? operation}) {
    return OperationsInfo(
        asset0Info: asset0Info ?? this.asset0Info,
        asset1Info: asset1Info ?? this.asset1Info,
        operation: operation ?? this.operation);
  }

  OperationsInfo copyWithWrapped(
      {Wrapped<AssetInfoSchema>? asset0Info,
      Wrapped<AssetInfoSchema>? asset1Info,
      Wrapped<OperationStat>? operation}) {
    return OperationsInfo(
        asset0Info: (asset0Info != null ? asset0Info.value : this.asset0Info),
        asset1Info: (asset1Info != null ? asset1Info.value : this.asset1Info),
        operation: (operation != null ? operation.value : this.operation));
  }
}

@JsonSerializable(explicitToJson: true)
class PoolInfoSchema {
  const PoolInfoSchema({
    required this.address,
    this.apy1d,
    this.apy30d,
    this.apy7d,
    required this.collectedToken0ProtocolFee,
    required this.collectedToken1ProtocolFee,
    required this.deprecated,
    this.lpAccountAddress,
    this.lpBalance,
    required this.lpFee,
    this.lpPriceUsd,
    required this.lpTotalSupply,
    this.lpTotalSupplyUsd,
    this.lpWalletAddress,
    required this.protocolFee,
    required this.protocolFeeAddress,
    required this.refFee,
    required this.reserve0,
    required this.reserve1,
    required this.routerAddress,
    required this.token0Address,
    this.token0Balance,
    required this.token1Address,
    this.token1Balance,
  });

  factory PoolInfoSchema.fromJson(Map<String, dynamic> json) =>
      _$PoolInfoSchemaFromJson(json);

  static const toJsonFactory = _$PoolInfoSchemaToJson;
  Map<String, dynamic> toJson() => _$PoolInfoSchemaToJson(this);

  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'apy_1d')
  final String? apy1d;
  @JsonKey(name: 'apy_30d')
  final String? apy30d;
  @JsonKey(name: 'apy_7d')
  final String? apy7d;
  @JsonKey(name: 'collected_token0_protocol_fee')
  final String collectedToken0ProtocolFee;
  @JsonKey(name: 'collected_token1_protocol_fee')
  final String collectedToken1ProtocolFee;
  @JsonKey(name: 'deprecated')
  final bool deprecated;
  @JsonKey(name: 'lp_account_address')
  final String? lpAccountAddress;
  @JsonKey(name: 'lp_balance')
  final String? lpBalance;
  @JsonKey(name: 'lp_fee')
  final String lpFee;
  @JsonKey(name: 'lp_price_usd')
  final String? lpPriceUsd;
  @JsonKey(name: 'lp_total_supply')
  final String lpTotalSupply;
  @JsonKey(name: 'lp_total_supply_usd')
  final String? lpTotalSupplyUsd;
  @JsonKey(name: 'lp_wallet_address')
  final String? lpWalletAddress;
  @JsonKey(name: 'protocol_fee')
  final String protocolFee;
  @JsonKey(name: 'protocol_fee_address')
  final String protocolFeeAddress;
  @JsonKey(name: 'ref_fee')
  final String refFee;
  @JsonKey(name: 'reserve0')
  final String reserve0;
  @JsonKey(name: 'reserve1')
  final String reserve1;
  @JsonKey(name: 'router_address')
  final String routerAddress;
  @JsonKey(name: 'token0_address')
  final String token0Address;
  @JsonKey(name: 'token0_balance')
  final String? token0Balance;
  @JsonKey(name: 'token1_address')
  final String token1Address;
  @JsonKey(name: 'token1_balance')
  final String? token1Balance;
  static const fromJsonFactory = _$PoolInfoSchemaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PoolInfoSchema &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.apy1d, apy1d) ||
                const DeepCollectionEquality().equals(other.apy1d, apy1d)) &&
            (identical(other.apy30d, apy30d) ||
                const DeepCollectionEquality().equals(other.apy30d, apy30d)) &&
            (identical(other.apy7d, apy7d) ||
                const DeepCollectionEquality().equals(other.apy7d, apy7d)) &&
            (identical(other.collectedToken0ProtocolFee, collectedToken0ProtocolFee) ||
                const DeepCollectionEquality().equals(
                    other.collectedToken0ProtocolFee,
                    collectedToken0ProtocolFee)) &&
            (identical(other.collectedToken1ProtocolFee, collectedToken1ProtocolFee) ||
                const DeepCollectionEquality().equals(
                    other.collectedToken1ProtocolFee,
                    collectedToken1ProtocolFee)) &&
            (identical(other.deprecated, deprecated) ||
                const DeepCollectionEquality()
                    .equals(other.deprecated, deprecated)) &&
            (identical(other.lpAccountAddress, lpAccountAddress) ||
                const DeepCollectionEquality()
                    .equals(other.lpAccountAddress, lpAccountAddress)) &&
            (identical(other.lpBalance, lpBalance) ||
                const DeepCollectionEquality()
                    .equals(other.lpBalance, lpBalance)) &&
            (identical(other.lpFee, lpFee) ||
                const DeepCollectionEquality().equals(other.lpFee, lpFee)) &&
            (identical(other.lpPriceUsd, lpPriceUsd) ||
                const DeepCollectionEquality()
                    .equals(other.lpPriceUsd, lpPriceUsd)) &&
            (identical(other.lpTotalSupply, lpTotalSupply) ||
                const DeepCollectionEquality()
                    .equals(other.lpTotalSupply, lpTotalSupply)) &&
            (identical(other.lpTotalSupplyUsd, lpTotalSupplyUsd) ||
                const DeepCollectionEquality()
                    .equals(other.lpTotalSupplyUsd, lpTotalSupplyUsd)) &&
            (identical(other.lpWalletAddress, lpWalletAddress) ||
                const DeepCollectionEquality()
                    .equals(other.lpWalletAddress, lpWalletAddress)) &&
            (identical(other.protocolFee, protocolFee) ||
                const DeepCollectionEquality()
                    .equals(other.protocolFee, protocolFee)) &&
            (identical(other.protocolFeeAddress, protocolFeeAddress) ||
                const DeepCollectionEquality()
                    .equals(other.protocolFeeAddress, protocolFeeAddress)) &&
            (identical(other.refFee, refFee) ||
                const DeepCollectionEquality().equals(other.refFee, refFee)) &&
            (identical(other.reserve0, reserve0) || const DeepCollectionEquality().equals(other.reserve0, reserve0)) &&
            (identical(other.reserve1, reserve1) || const DeepCollectionEquality().equals(other.reserve1, reserve1)) &&
            (identical(other.routerAddress, routerAddress) || const DeepCollectionEquality().equals(other.routerAddress, routerAddress)) &&
            (identical(other.token0Address, token0Address) || const DeepCollectionEquality().equals(other.token0Address, token0Address)) &&
            (identical(other.token0Balance, token0Balance) || const DeepCollectionEquality().equals(other.token0Balance, token0Balance)) &&
            (identical(other.token1Address, token1Address) || const DeepCollectionEquality().equals(other.token1Address, token1Address)) &&
            (identical(other.token1Balance, token1Balance) || const DeepCollectionEquality().equals(other.token1Balance, token1Balance)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(apy1d) ^
      const DeepCollectionEquality().hash(apy30d) ^
      const DeepCollectionEquality().hash(apy7d) ^
      const DeepCollectionEquality().hash(collectedToken0ProtocolFee) ^
      const DeepCollectionEquality().hash(collectedToken1ProtocolFee) ^
      const DeepCollectionEquality().hash(deprecated) ^
      const DeepCollectionEquality().hash(lpAccountAddress) ^
      const DeepCollectionEquality().hash(lpBalance) ^
      const DeepCollectionEquality().hash(lpFee) ^
      const DeepCollectionEquality().hash(lpPriceUsd) ^
      const DeepCollectionEquality().hash(lpTotalSupply) ^
      const DeepCollectionEquality().hash(lpTotalSupplyUsd) ^
      const DeepCollectionEquality().hash(lpWalletAddress) ^
      const DeepCollectionEquality().hash(protocolFee) ^
      const DeepCollectionEquality().hash(protocolFeeAddress) ^
      const DeepCollectionEquality().hash(refFee) ^
      const DeepCollectionEquality().hash(reserve0) ^
      const DeepCollectionEquality().hash(reserve1) ^
      const DeepCollectionEquality().hash(routerAddress) ^
      const DeepCollectionEquality().hash(token0Address) ^
      const DeepCollectionEquality().hash(token0Balance) ^
      const DeepCollectionEquality().hash(token1Address) ^
      const DeepCollectionEquality().hash(token1Balance) ^
      runtimeType.hashCode;
}

extension $PoolInfoSchemaExtension on PoolInfoSchema {
  PoolInfoSchema copyWith(
      {String? address,
      String? apy1d,
      String? apy30d,
      String? apy7d,
      String? collectedToken0ProtocolFee,
      String? collectedToken1ProtocolFee,
      bool? deprecated,
      String? lpAccountAddress,
      String? lpBalance,
      String? lpFee,
      String? lpPriceUsd,
      String? lpTotalSupply,
      String? lpTotalSupplyUsd,
      String? lpWalletAddress,
      String? protocolFee,
      String? protocolFeeAddress,
      String? refFee,
      String? reserve0,
      String? reserve1,
      String? routerAddress,
      String? token0Address,
      String? token0Balance,
      String? token1Address,
      String? token1Balance}) {
    return PoolInfoSchema(
        address: address ?? this.address,
        apy1d: apy1d ?? this.apy1d,
        apy30d: apy30d ?? this.apy30d,
        apy7d: apy7d ?? this.apy7d,
        collectedToken0ProtocolFee:
            collectedToken0ProtocolFee ?? this.collectedToken0ProtocolFee,
        collectedToken1ProtocolFee:
            collectedToken1ProtocolFee ?? this.collectedToken1ProtocolFee,
        deprecated: deprecated ?? this.deprecated,
        lpAccountAddress: lpAccountAddress ?? this.lpAccountAddress,
        lpBalance: lpBalance ?? this.lpBalance,
        lpFee: lpFee ?? this.lpFee,
        lpPriceUsd: lpPriceUsd ?? this.lpPriceUsd,
        lpTotalSupply: lpTotalSupply ?? this.lpTotalSupply,
        lpTotalSupplyUsd: lpTotalSupplyUsd ?? this.lpTotalSupplyUsd,
        lpWalletAddress: lpWalletAddress ?? this.lpWalletAddress,
        protocolFee: protocolFee ?? this.protocolFee,
        protocolFeeAddress: protocolFeeAddress ?? this.protocolFeeAddress,
        refFee: refFee ?? this.refFee,
        reserve0: reserve0 ?? this.reserve0,
        reserve1: reserve1 ?? this.reserve1,
        routerAddress: routerAddress ?? this.routerAddress,
        token0Address: token0Address ?? this.token0Address,
        token0Balance: token0Balance ?? this.token0Balance,
        token1Address: token1Address ?? this.token1Address,
        token1Balance: token1Balance ?? this.token1Balance);
  }

  PoolInfoSchema copyWithWrapped(
      {Wrapped<String>? address,
      Wrapped<String?>? apy1d,
      Wrapped<String?>? apy30d,
      Wrapped<String?>? apy7d,
      Wrapped<String>? collectedToken0ProtocolFee,
      Wrapped<String>? collectedToken1ProtocolFee,
      Wrapped<bool>? deprecated,
      Wrapped<String?>? lpAccountAddress,
      Wrapped<String?>? lpBalance,
      Wrapped<String>? lpFee,
      Wrapped<String?>? lpPriceUsd,
      Wrapped<String>? lpTotalSupply,
      Wrapped<String?>? lpTotalSupplyUsd,
      Wrapped<String?>? lpWalletAddress,
      Wrapped<String>? protocolFee,
      Wrapped<String>? protocolFeeAddress,
      Wrapped<String>? refFee,
      Wrapped<String>? reserve0,
      Wrapped<String>? reserve1,
      Wrapped<String>? routerAddress,
      Wrapped<String>? token0Address,
      Wrapped<String?>? token0Balance,
      Wrapped<String>? token1Address,
      Wrapped<String?>? token1Balance}) {
    return PoolInfoSchema(
        address: (address != null ? address.value : this.address),
        apy1d: (apy1d != null ? apy1d.value : this.apy1d),
        apy30d: (apy30d != null ? apy30d.value : this.apy30d),
        apy7d: (apy7d != null ? apy7d.value : this.apy7d),
        collectedToken0ProtocolFee: (collectedToken0ProtocolFee != null
            ? collectedToken0ProtocolFee.value
            : this.collectedToken0ProtocolFee),
        collectedToken1ProtocolFee: (collectedToken1ProtocolFee != null
            ? collectedToken1ProtocolFee.value
            : this.collectedToken1ProtocolFee),
        deprecated: (deprecated != null ? deprecated.value : this.deprecated),
        lpAccountAddress: (lpAccountAddress != null
            ? lpAccountAddress.value
            : this.lpAccountAddress),
        lpBalance: (lpBalance != null ? lpBalance.value : this.lpBalance),
        lpFee: (lpFee != null ? lpFee.value : this.lpFee),
        lpPriceUsd: (lpPriceUsd != null ? lpPriceUsd.value : this.lpPriceUsd),
        lpTotalSupply:
            (lpTotalSupply != null ? lpTotalSupply.value : this.lpTotalSupply),
        lpTotalSupplyUsd: (lpTotalSupplyUsd != null
            ? lpTotalSupplyUsd.value
            : this.lpTotalSupplyUsd),
        lpWalletAddress: (lpWalletAddress != null
            ? lpWalletAddress.value
            : this.lpWalletAddress),
        protocolFee:
            (protocolFee != null ? protocolFee.value : this.protocolFee),
        protocolFeeAddress: (protocolFeeAddress != null
            ? protocolFeeAddress.value
            : this.protocolFeeAddress),
        refFee: (refFee != null ? refFee.value : this.refFee),
        reserve0: (reserve0 != null ? reserve0.value : this.reserve0),
        reserve1: (reserve1 != null ? reserve1.value : this.reserve1),
        routerAddress:
            (routerAddress != null ? routerAddress.value : this.routerAddress),
        token0Address:
            (token0Address != null ? token0Address.value : this.token0Address),
        token0Balance:
            (token0Balance != null ? token0Balance.value : this.token0Balance),
        token1Address:
            (token1Address != null ? token1Address.value : this.token1Address),
        token1Balance:
            (token1Balance != null ? token1Balance.value : this.token1Balance));
  }
}

@JsonSerializable(explicitToJson: true)
class PoolInfoScreenerSchema {
  const PoolInfoScreenerSchema({
    required this.asset0Id,
    required this.asset1Id,
    this.createdAtBlockNumber,
    this.createdAtBlockTimestamp,
    this.createdAtTxnId,
    this.feeBps,
    required this.id,
  });

  factory PoolInfoScreenerSchema.fromJson(Map<String, dynamic> json) =>
      _$PoolInfoScreenerSchemaFromJson(json);

  static const toJsonFactory = _$PoolInfoScreenerSchemaToJson;
  Map<String, dynamic> toJson() => _$PoolInfoScreenerSchemaToJson(this);

  @JsonKey(name: 'asset0Id')
  final String asset0Id;
  @JsonKey(name: 'asset1Id')
  final String asset1Id;
  @JsonKey(name: 'createdAtBlockNumber')
  final int? createdAtBlockNumber;
  @JsonKey(name: 'createdAtBlockTimestamp')
  final int? createdAtBlockTimestamp;
  @JsonKey(name: 'createdAtTxnId')
  final String? createdAtTxnId;
  @JsonKey(name: 'feeBps')
  final int? feeBps;
  @JsonKey(name: 'id')
  final String id;
  static const fromJsonFactory = _$PoolInfoScreenerSchemaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PoolInfoScreenerSchema &&
            (identical(other.asset0Id, asset0Id) ||
                const DeepCollectionEquality()
                    .equals(other.asset0Id, asset0Id)) &&
            (identical(other.asset1Id, asset1Id) ||
                const DeepCollectionEquality()
                    .equals(other.asset1Id, asset1Id)) &&
            (identical(other.createdAtBlockNumber, createdAtBlockNumber) ||
                const DeepCollectionEquality().equals(
                    other.createdAtBlockNumber, createdAtBlockNumber)) &&
            (identical(
                    other.createdAtBlockTimestamp, createdAtBlockTimestamp) ||
                const DeepCollectionEquality().equals(
                    other.createdAtBlockTimestamp, createdAtBlockTimestamp)) &&
            (identical(other.createdAtTxnId, createdAtTxnId) ||
                const DeepCollectionEquality()
                    .equals(other.createdAtTxnId, createdAtTxnId)) &&
            (identical(other.feeBps, feeBps) ||
                const DeepCollectionEquality().equals(other.feeBps, feeBps)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(asset0Id) ^
      const DeepCollectionEquality().hash(asset1Id) ^
      const DeepCollectionEquality().hash(createdAtBlockNumber) ^
      const DeepCollectionEquality().hash(createdAtBlockTimestamp) ^
      const DeepCollectionEquality().hash(createdAtTxnId) ^
      const DeepCollectionEquality().hash(feeBps) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $PoolInfoScreenerSchemaExtension on PoolInfoScreenerSchema {
  PoolInfoScreenerSchema copyWith(
      {String? asset0Id,
      String? asset1Id,
      int? createdAtBlockNumber,
      int? createdAtBlockTimestamp,
      String? createdAtTxnId,
      int? feeBps,
      String? id}) {
    return PoolInfoScreenerSchema(
        asset0Id: asset0Id ?? this.asset0Id,
        asset1Id: asset1Id ?? this.asset1Id,
        createdAtBlockNumber: createdAtBlockNumber ?? this.createdAtBlockNumber,
        createdAtBlockTimestamp:
            createdAtBlockTimestamp ?? this.createdAtBlockTimestamp,
        createdAtTxnId: createdAtTxnId ?? this.createdAtTxnId,
        feeBps: feeBps ?? this.feeBps,
        id: id ?? this.id);
  }

  PoolInfoScreenerSchema copyWithWrapped(
      {Wrapped<String>? asset0Id,
      Wrapped<String>? asset1Id,
      Wrapped<int?>? createdAtBlockNumber,
      Wrapped<int?>? createdAtBlockTimestamp,
      Wrapped<String?>? createdAtTxnId,
      Wrapped<int?>? feeBps,
      Wrapped<String>? id}) {
    return PoolInfoScreenerSchema(
        asset0Id: (asset0Id != null ? asset0Id.value : this.asset0Id),
        asset1Id: (asset1Id != null ? asset1Id.value : this.asset1Id),
        createdAtBlockNumber: (createdAtBlockNumber != null
            ? createdAtBlockNumber.value
            : this.createdAtBlockNumber),
        createdAtBlockTimestamp: (createdAtBlockTimestamp != null
            ? createdAtBlockTimestamp.value
            : this.createdAtBlockTimestamp),
        createdAtTxnId: (createdAtTxnId != null
            ? createdAtTxnId.value
            : this.createdAtTxnId),
        feeBps: (feeBps != null ? feeBps.value : this.feeBps),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class PoolStats {
  const PoolStats({
    this.apy,
    required this.baseId,
    required this.baseLiquidity,
    required this.baseName,
    required this.baseSymbol,
    required this.baseVolume,
    required this.lastPrice,
    required this.lpPrice,
    required this.lpPriceUsd,
    required this.poolAddress,
    required this.quoteId,
    required this.quoteLiquidity,
    required this.quoteName,
    required this.quoteSymbol,
    required this.quoteVolume,
    required this.routerAddress,
    required this.url,
  });

  factory PoolStats.fromJson(Map<String, dynamic> json) =>
      _$PoolStatsFromJson(json);

  static const toJsonFactory = _$PoolStatsToJson;
  Map<String, dynamic> toJson() => _$PoolStatsToJson(this);

  @JsonKey(name: 'apy')
  final String? apy;
  @JsonKey(name: 'base_id')
  final String baseId;
  @JsonKey(name: 'base_liquidity')
  final String baseLiquidity;
  @JsonKey(name: 'base_name')
  final String baseName;
  @JsonKey(name: 'base_symbol')
  final String baseSymbol;
  @JsonKey(name: 'base_volume')
  final String baseVolume;
  @JsonKey(name: 'last_price')
  final String lastPrice;
  @JsonKey(name: 'lp_price')
  final String lpPrice;
  @JsonKey(name: 'lp_price_usd')
  final String lpPriceUsd;
  @JsonKey(name: 'pool_address')
  final String poolAddress;
  @JsonKey(name: 'quote_id')
  final String quoteId;
  @JsonKey(name: 'quote_liquidity')
  final String quoteLiquidity;
  @JsonKey(name: 'quote_name')
  final String quoteName;
  @JsonKey(name: 'quote_symbol')
  final String quoteSymbol;
  @JsonKey(name: 'quote_volume')
  final String quoteVolume;
  @JsonKey(name: 'router_address')
  final String routerAddress;
  @JsonKey(name: 'url')
  final String url;
  static const fromJsonFactory = _$PoolStatsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PoolStats &&
            (identical(other.apy, apy) ||
                const DeepCollectionEquality().equals(other.apy, apy)) &&
            (identical(other.baseId, baseId) ||
                const DeepCollectionEquality().equals(other.baseId, baseId)) &&
            (identical(other.baseLiquidity, baseLiquidity) ||
                const DeepCollectionEquality()
                    .equals(other.baseLiquidity, baseLiquidity)) &&
            (identical(other.baseName, baseName) ||
                const DeepCollectionEquality()
                    .equals(other.baseName, baseName)) &&
            (identical(other.baseSymbol, baseSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.baseSymbol, baseSymbol)) &&
            (identical(other.baseVolume, baseVolume) ||
                const DeepCollectionEquality()
                    .equals(other.baseVolume, baseVolume)) &&
            (identical(other.lastPrice, lastPrice) ||
                const DeepCollectionEquality()
                    .equals(other.lastPrice, lastPrice)) &&
            (identical(other.lpPrice, lpPrice) ||
                const DeepCollectionEquality()
                    .equals(other.lpPrice, lpPrice)) &&
            (identical(other.lpPriceUsd, lpPriceUsd) ||
                const DeepCollectionEquality()
                    .equals(other.lpPriceUsd, lpPriceUsd)) &&
            (identical(other.poolAddress, poolAddress) ||
                const DeepCollectionEquality()
                    .equals(other.poolAddress, poolAddress)) &&
            (identical(other.quoteId, quoteId) ||
                const DeepCollectionEquality()
                    .equals(other.quoteId, quoteId)) &&
            (identical(other.quoteLiquidity, quoteLiquidity) ||
                const DeepCollectionEquality()
                    .equals(other.quoteLiquidity, quoteLiquidity)) &&
            (identical(other.quoteName, quoteName) ||
                const DeepCollectionEquality()
                    .equals(other.quoteName, quoteName)) &&
            (identical(other.quoteSymbol, quoteSymbol) ||
                const DeepCollectionEquality()
                    .equals(other.quoteSymbol, quoteSymbol)) &&
            (identical(other.quoteVolume, quoteVolume) ||
                const DeepCollectionEquality()
                    .equals(other.quoteVolume, quoteVolume)) &&
            (identical(other.routerAddress, routerAddress) ||
                const DeepCollectionEquality()
                    .equals(other.routerAddress, routerAddress)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(apy) ^
      const DeepCollectionEquality().hash(baseId) ^
      const DeepCollectionEquality().hash(baseLiquidity) ^
      const DeepCollectionEquality().hash(baseName) ^
      const DeepCollectionEquality().hash(baseSymbol) ^
      const DeepCollectionEquality().hash(baseVolume) ^
      const DeepCollectionEquality().hash(lastPrice) ^
      const DeepCollectionEquality().hash(lpPrice) ^
      const DeepCollectionEquality().hash(lpPriceUsd) ^
      const DeepCollectionEquality().hash(poolAddress) ^
      const DeepCollectionEquality().hash(quoteId) ^
      const DeepCollectionEquality().hash(quoteLiquidity) ^
      const DeepCollectionEquality().hash(quoteName) ^
      const DeepCollectionEquality().hash(quoteSymbol) ^
      const DeepCollectionEquality().hash(quoteVolume) ^
      const DeepCollectionEquality().hash(routerAddress) ^
      const DeepCollectionEquality().hash(url) ^
      runtimeType.hashCode;
}

extension $PoolStatsExtension on PoolStats {
  PoolStats copyWith(
      {String? apy,
      String? baseId,
      String? baseLiquidity,
      String? baseName,
      String? baseSymbol,
      String? baseVolume,
      String? lastPrice,
      String? lpPrice,
      String? lpPriceUsd,
      String? poolAddress,
      String? quoteId,
      String? quoteLiquidity,
      String? quoteName,
      String? quoteSymbol,
      String? quoteVolume,
      String? routerAddress,
      String? url}) {
    return PoolStats(
        apy: apy ?? this.apy,
        baseId: baseId ?? this.baseId,
        baseLiquidity: baseLiquidity ?? this.baseLiquidity,
        baseName: baseName ?? this.baseName,
        baseSymbol: baseSymbol ?? this.baseSymbol,
        baseVolume: baseVolume ?? this.baseVolume,
        lastPrice: lastPrice ?? this.lastPrice,
        lpPrice: lpPrice ?? this.lpPrice,
        lpPriceUsd: lpPriceUsd ?? this.lpPriceUsd,
        poolAddress: poolAddress ?? this.poolAddress,
        quoteId: quoteId ?? this.quoteId,
        quoteLiquidity: quoteLiquidity ?? this.quoteLiquidity,
        quoteName: quoteName ?? this.quoteName,
        quoteSymbol: quoteSymbol ?? this.quoteSymbol,
        quoteVolume: quoteVolume ?? this.quoteVolume,
        routerAddress: routerAddress ?? this.routerAddress,
        url: url ?? this.url);
  }

  PoolStats copyWithWrapped(
      {Wrapped<String?>? apy,
      Wrapped<String>? baseId,
      Wrapped<String>? baseLiquidity,
      Wrapped<String>? baseName,
      Wrapped<String>? baseSymbol,
      Wrapped<String>? baseVolume,
      Wrapped<String>? lastPrice,
      Wrapped<String>? lpPrice,
      Wrapped<String>? lpPriceUsd,
      Wrapped<String>? poolAddress,
      Wrapped<String>? quoteId,
      Wrapped<String>? quoteLiquidity,
      Wrapped<String>? quoteName,
      Wrapped<String>? quoteSymbol,
      Wrapped<String>? quoteVolume,
      Wrapped<String>? routerAddress,
      Wrapped<String>? url}) {
    return PoolStats(
        apy: (apy != null ? apy.value : this.apy),
        baseId: (baseId != null ? baseId.value : this.baseId),
        baseLiquidity:
            (baseLiquidity != null ? baseLiquidity.value : this.baseLiquidity),
        baseName: (baseName != null ? baseName.value : this.baseName),
        baseSymbol: (baseSymbol != null ? baseSymbol.value : this.baseSymbol),
        baseVolume: (baseVolume != null ? baseVolume.value : this.baseVolume),
        lastPrice: (lastPrice != null ? lastPrice.value : this.lastPrice),
        lpPrice: (lpPrice != null ? lpPrice.value : this.lpPrice),
        lpPriceUsd: (lpPriceUsd != null ? lpPriceUsd.value : this.lpPriceUsd),
        poolAddress:
            (poolAddress != null ? poolAddress.value : this.poolAddress),
        quoteId: (quoteId != null ? quoteId.value : this.quoteId),
        quoteLiquidity: (quoteLiquidity != null
            ? quoteLiquidity.value
            : this.quoteLiquidity),
        quoteName: (quoteName != null ? quoteName.value : this.quoteName),
        quoteSymbol:
            (quoteSymbol != null ? quoteSymbol.value : this.quoteSymbol),
        quoteVolume:
            (quoteVolume != null ? quoteVolume.value : this.quoteVolume),
        routerAddress:
            (routerAddress != null ? routerAddress.value : this.routerAddress),
        url: (url != null ? url.value : this.url));
  }
}

@JsonSerializable(explicitToJson: true)
class Reserves {
  const Reserves({
    required this.asset0,
    required this.asset1,
  });

  factory Reserves.fromJson(Map<String, dynamic> json) =>
      _$ReservesFromJson(json);

  static const toJsonFactory = _$ReservesToJson;
  Map<String, dynamic> toJson() => _$ReservesToJson(this);

  @JsonKey(name: 'asset0')
  final String asset0;
  @JsonKey(name: 'asset1')
  final String asset1;
  static const fromJsonFactory = _$ReservesFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Reserves &&
            (identical(other.asset0, asset0) ||
                const DeepCollectionEquality().equals(other.asset0, asset0)) &&
            (identical(other.asset1, asset1) ||
                const DeepCollectionEquality().equals(other.asset1, asset1)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(asset0) ^
      const DeepCollectionEquality().hash(asset1) ^
      runtimeType.hashCode;
}

extension $ReservesExtension on Reserves {
  Reserves copyWith({String? asset0, String? asset1}) {
    return Reserves(
        asset0: asset0 ?? this.asset0, asset1: asset1 ?? this.asset1);
  }

  Reserves copyWithWrapped({Wrapped<String>? asset0, Wrapped<String>? asset1}) {
    return Reserves(
        asset0: (asset0 != null ? asset0.value : this.asset0),
        asset1: (asset1 != null ? asset1.value : this.asset1));
  }
}

@JsonSerializable(explicitToJson: true)
class SwapEvent {
  const SwapEvent({
    this.amount0In,
    this.amount0Out,
    this.amount1In,
    this.amount1Out,
    required this.eventIndex,
    required this.maker,
    required this.pairId,
    required this.priceNative,
    this.reserves,
    required this.txnId,
    required this.txnIndex,
  });

  factory SwapEvent.fromJson(Map<String, dynamic> json) =>
      _$SwapEventFromJson(json);

  static const toJsonFactory = _$SwapEventToJson;
  Map<String, dynamic> toJson() => _$SwapEventToJson(this);

  @JsonKey(name: 'amount0In')
  final String? amount0In;
  @JsonKey(name: 'amount0Out')
  final String? amount0Out;
  @JsonKey(name: 'amount1In')
  final String? amount1In;
  @JsonKey(name: 'amount1Out')
  final String? amount1Out;
  @JsonKey(name: 'eventIndex')
  final int eventIndex;
  @JsonKey(name: 'maker')
  final String maker;
  @JsonKey(name: 'pairId')
  final String pairId;
  @JsonKey(name: 'priceNative')
  final String priceNative;
  @JsonKey(name: 'reserves')
  final Reserves? reserves;
  @JsonKey(name: 'txnId')
  final String txnId;
  @JsonKey(name: 'txnIndex')
  final int txnIndex;
  static const fromJsonFactory = _$SwapEventFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SwapEvent &&
            (identical(other.amount0In, amount0In) ||
                const DeepCollectionEquality()
                    .equals(other.amount0In, amount0In)) &&
            (identical(other.amount0Out, amount0Out) ||
                const DeepCollectionEquality()
                    .equals(other.amount0Out, amount0Out)) &&
            (identical(other.amount1In, amount1In) ||
                const DeepCollectionEquality()
                    .equals(other.amount1In, amount1In)) &&
            (identical(other.amount1Out, amount1Out) ||
                const DeepCollectionEquality()
                    .equals(other.amount1Out, amount1Out)) &&
            (identical(other.eventIndex, eventIndex) ||
                const DeepCollectionEquality()
                    .equals(other.eventIndex, eventIndex)) &&
            (identical(other.maker, maker) ||
                const DeepCollectionEquality().equals(other.maker, maker)) &&
            (identical(other.pairId, pairId) ||
                const DeepCollectionEquality().equals(other.pairId, pairId)) &&
            (identical(other.priceNative, priceNative) ||
                const DeepCollectionEquality()
                    .equals(other.priceNative, priceNative)) &&
            (identical(other.reserves, reserves) ||
                const DeepCollectionEquality()
                    .equals(other.reserves, reserves)) &&
            (identical(other.txnId, txnId) ||
                const DeepCollectionEquality().equals(other.txnId, txnId)) &&
            (identical(other.txnIndex, txnIndex) ||
                const DeepCollectionEquality()
                    .equals(other.txnIndex, txnIndex)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(amount0In) ^
      const DeepCollectionEquality().hash(amount0Out) ^
      const DeepCollectionEquality().hash(amount1In) ^
      const DeepCollectionEquality().hash(amount1Out) ^
      const DeepCollectionEquality().hash(eventIndex) ^
      const DeepCollectionEquality().hash(maker) ^
      const DeepCollectionEquality().hash(pairId) ^
      const DeepCollectionEquality().hash(priceNative) ^
      const DeepCollectionEquality().hash(reserves) ^
      const DeepCollectionEquality().hash(txnId) ^
      const DeepCollectionEquality().hash(txnIndex) ^
      runtimeType.hashCode;
}

extension $SwapEventExtension on SwapEvent {
  SwapEvent copyWith(
      {String? amount0In,
      String? amount0Out,
      String? amount1In,
      String? amount1Out,
      int? eventIndex,
      String? maker,
      String? pairId,
      String? priceNative,
      Reserves? reserves,
      String? txnId,
      int? txnIndex}) {
    return SwapEvent(
        amount0In: amount0In ?? this.amount0In,
        amount0Out: amount0Out ?? this.amount0Out,
        amount1In: amount1In ?? this.amount1In,
        amount1Out: amount1Out ?? this.amount1Out,
        eventIndex: eventIndex ?? this.eventIndex,
        maker: maker ?? this.maker,
        pairId: pairId ?? this.pairId,
        priceNative: priceNative ?? this.priceNative,
        reserves: reserves ?? this.reserves,
        txnId: txnId ?? this.txnId,
        txnIndex: txnIndex ?? this.txnIndex);
  }

  SwapEvent copyWithWrapped(
      {Wrapped<String?>? amount0In,
      Wrapped<String?>? amount0Out,
      Wrapped<String?>? amount1In,
      Wrapped<String?>? amount1Out,
      Wrapped<int>? eventIndex,
      Wrapped<String>? maker,
      Wrapped<String>? pairId,
      Wrapped<String>? priceNative,
      Wrapped<Reserves?>? reserves,
      Wrapped<String>? txnId,
      Wrapped<int>? txnIndex}) {
    return SwapEvent(
        amount0In: (amount0In != null ? amount0In.value : this.amount0In),
        amount0Out: (amount0Out != null ? amount0Out.value : this.amount0Out),
        amount1In: (amount1In != null ? amount1In.value : this.amount1In),
        amount1Out: (amount1Out != null ? amount1Out.value : this.amount1Out),
        eventIndex: (eventIndex != null ? eventIndex.value : this.eventIndex),
        maker: (maker != null ? maker.value : this.maker),
        pairId: (pairId != null ? pairId.value : this.pairId),
        priceNative:
            (priceNative != null ? priceNative.value : this.priceNative),
        reserves: (reserves != null ? reserves.value : this.reserves),
        txnId: (txnId != null ? txnId.value : this.txnId),
        txnIndex: (txnIndex != null ? txnIndex.value : this.txnIndex));
  }
}

@JsonSerializable(explicitToJson: true)
class AddressResponse$Response {
  const AddressResponse$Response({
    required this.address,
  });

  factory AddressResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$AddressResponse$ResponseFromJson(json);

  static const toJsonFactory = _$AddressResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$AddressResponse$ResponseToJson(this);

  @JsonKey(name: 'address')
  final String address;
  static const fromJsonFactory = _$AddressResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AddressResponse$Response &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(address) ^ runtimeType.hashCode;
}

extension $AddressResponse$ResponseExtension on AddressResponse$Response {
  AddressResponse$Response copyWith({String? address}) {
    return AddressResponse$Response(address: address ?? this.address);
  }

  AddressResponse$Response copyWithWrapped({Wrapped<String>? address}) {
    return AddressResponse$Response(
        address: (address != null ? address.value : this.address));
  }
}

@JsonSerializable(explicitToJson: true)
class AssetInfoScreenerResponse$Response {
  const AssetInfoScreenerResponse$Response({
    required this.asset,
  });

  factory AssetInfoScreenerResponse$Response.fromJson(
          Map<String, dynamic> json) =>
      _$AssetInfoScreenerResponse$ResponseFromJson(json);

  static const toJsonFactory = _$AssetInfoScreenerResponse$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$AssetInfoScreenerResponse$ResponseToJson(this);

  @JsonKey(name: 'asset')
  final AssetInfoScreenerSchema asset;
  static const fromJsonFactory = _$AssetInfoScreenerResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssetInfoScreenerResponse$Response &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(asset) ^ runtimeType.hashCode;
}

extension $AssetInfoScreenerResponse$ResponseExtension
    on AssetInfoScreenerResponse$Response {
  AssetInfoScreenerResponse$Response copyWith(
      {AssetInfoScreenerSchema? asset}) {
    return AssetInfoScreenerResponse$Response(asset: asset ?? this.asset);
  }

  AssetInfoScreenerResponse$Response copyWithWrapped(
      {Wrapped<AssetInfoScreenerSchema>? asset}) {
    return AssetInfoScreenerResponse$Response(
        asset: (asset != null ? asset.value : this.asset));
  }
}

@JsonSerializable(explicitToJson: true)
class AssetListResponse$Response {
  const AssetListResponse$Response({
    required this.assetList,
  });

  factory AssetListResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$AssetListResponse$ResponseFromJson(json);

  static const toJsonFactory = _$AssetListResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$AssetListResponse$ResponseToJson(this);

  @JsonKey(name: 'asset_list', defaultValue: <AssetInfoSchema>[])
  final List<AssetInfoSchema> assetList;
  static const fromJsonFactory = _$AssetListResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssetListResponse$Response &&
            (identical(other.assetList, assetList) ||
                const DeepCollectionEquality()
                    .equals(other.assetList, assetList)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(assetList) ^ runtimeType.hashCode;
}

extension $AssetListResponse$ResponseExtension on AssetListResponse$Response {
  AssetListResponse$Response copyWith({List<AssetInfoSchema>? assetList}) {
    return AssetListResponse$Response(assetList: assetList ?? this.assetList);
  }

  AssetListResponse$Response copyWithWrapped(
      {Wrapped<List<AssetInfoSchema>>? assetList}) {
    return AssetListResponse$Response(
        assetList: (assetList != null ? assetList.value : this.assetList));
  }
}

@JsonSerializable(explicitToJson: true)
class AssetListResponseV2$Response {
  const AssetListResponseV2$Response({
    required this.assetList,
  });

  factory AssetListResponseV2$Response.fromJson(Map<String, dynamic> json) =>
      _$AssetListResponseV2$ResponseFromJson(json);

  static const toJsonFactory = _$AssetListResponseV2$ResponseToJson;
  Map<String, dynamic> toJson() => _$AssetListResponseV2$ResponseToJson(this);

  @JsonKey(name: 'asset_list', defaultValue: <AssetInfoSchemaV2>[])
  final List<AssetInfoSchemaV2> assetList;
  static const fromJsonFactory = _$AssetListResponseV2$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssetListResponseV2$Response &&
            (identical(other.assetList, assetList) ||
                const DeepCollectionEquality()
                    .equals(other.assetList, assetList)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(assetList) ^ runtimeType.hashCode;
}

extension $AssetListResponseV2$ResponseExtension
    on AssetListResponseV2$Response {
  AssetListResponseV2$Response copyWith({List<AssetInfoSchemaV2>? assetList}) {
    return AssetListResponseV2$Response(assetList: assetList ?? this.assetList);
  }

  AssetListResponseV2$Response copyWithWrapped(
      {Wrapped<List<AssetInfoSchemaV2>>? assetList}) {
    return AssetListResponseV2$Response(
        assetList: (assetList != null ? assetList.value : this.assetList));
  }
}

@JsonSerializable(explicitToJson: true)
class AssetResponse$Response {
  const AssetResponse$Response({
    required this.asset,
  });

  factory AssetResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$AssetResponse$ResponseFromJson(json);

  static const toJsonFactory = _$AssetResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$AssetResponse$ResponseToJson(this);

  @JsonKey(name: 'asset')
  final AssetInfoSchema asset;
  static const fromJsonFactory = _$AssetResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssetResponse$Response &&
            (identical(other.asset, asset) ||
                const DeepCollectionEquality().equals(other.asset, asset)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(asset) ^ runtimeType.hashCode;
}

extension $AssetResponse$ResponseExtension on AssetResponse$Response {
  AssetResponse$Response copyWith({AssetInfoSchema? asset}) {
    return AssetResponse$Response(asset: asset ?? this.asset);
  }

  AssetResponse$Response copyWithWrapped({Wrapped<AssetInfoSchema>? asset}) {
    return AssetResponse$Response(
        asset: (asset != null ? asset.value : this.asset));
  }
}

@JsonSerializable(explicitToJson: true)
class DexStatsResponse$Response {
  const DexStatsResponse$Response({
    required this.since,
    required this.stats,
    required this.until,
  });

  factory DexStatsResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$DexStatsResponse$ResponseFromJson(json);

  static const toJsonFactory = _$DexStatsResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$DexStatsResponse$ResponseToJson(this);

  @JsonKey(name: 'since')
  final String since;
  @JsonKey(name: 'stats')
  final DexStats stats;
  @JsonKey(name: 'until')
  final String until;
  static const fromJsonFactory = _$DexStatsResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DexStatsResponse$Response &&
            (identical(other.since, since) ||
                const DeepCollectionEquality().equals(other.since, since)) &&
            (identical(other.stats, stats) ||
                const DeepCollectionEquality().equals(other.stats, stats)) &&
            (identical(other.until, until) ||
                const DeepCollectionEquality().equals(other.until, until)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(since) ^
      const DeepCollectionEquality().hash(stats) ^
      const DeepCollectionEquality().hash(until) ^
      runtimeType.hashCode;
}

extension $DexStatsResponse$ResponseExtension on DexStatsResponse$Response {
  DexStatsResponse$Response copyWith(
      {String? since, DexStats? stats, String? until}) {
    return DexStatsResponse$Response(
        since: since ?? this.since,
        stats: stats ?? this.stats,
        until: until ?? this.until);
  }

  DexStatsResponse$Response copyWithWrapped(
      {Wrapped<String>? since,
      Wrapped<DexStats>? stats,
      Wrapped<String>? until}) {
    return DexStatsResponse$Response(
        since: (since != null ? since.value : this.since),
        stats: (stats != null ? stats.value : this.stats),
        until: (until != null ? until.value : this.until));
  }
}

@JsonSerializable(explicitToJson: true)
class EventsResponse$Response {
  const EventsResponse$Response({
    required this.event,
  });

  factory EventsResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$EventsResponse$ResponseFromJson(json);

  static const toJsonFactory = _$EventsResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$EventsResponse$ResponseToJson(this);

  @JsonKey(name: 'event')
  final EventSchema event;
  static const fromJsonFactory = _$EventsResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EventsResponse$Response &&
            (identical(other.event, event) ||
                const DeepCollectionEquality().equals(other.event, event)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(event) ^ runtimeType.hashCode;
}

extension $EventsResponse$ResponseExtension on EventsResponse$Response {
  EventsResponse$Response copyWith({EventSchema? event}) {
    return EventsResponse$Response(event: event ?? this.event);
  }

  EventsResponse$Response copyWithWrapped({Wrapped<EventSchema>? event}) {
    return EventsResponse$Response(
        event: (event != null ? event.value : this.event));
  }
}

@JsonSerializable(explicitToJson: true)
class FarmListResponse$Response {
  const FarmListResponse$Response({
    required this.farmList,
  });

  factory FarmListResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$FarmListResponse$ResponseFromJson(json);

  static const toJsonFactory = _$FarmListResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$FarmListResponse$ResponseToJson(this);

  @JsonKey(name: 'farm_list', defaultValue: <FarmInfoSchema>[])
  final List<FarmInfoSchema> farmList;
  static const fromJsonFactory = _$FarmListResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FarmListResponse$Response &&
            (identical(other.farmList, farmList) ||
                const DeepCollectionEquality()
                    .equals(other.farmList, farmList)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(farmList) ^ runtimeType.hashCode;
}

extension $FarmListResponse$ResponseExtension on FarmListResponse$Response {
  FarmListResponse$Response copyWith({List<FarmInfoSchema>? farmList}) {
    return FarmListResponse$Response(farmList: farmList ?? this.farmList);
  }

  FarmListResponse$Response copyWithWrapped(
      {Wrapped<List<FarmInfoSchema>>? farmList}) {
    return FarmListResponse$Response(
        farmList: (farmList != null ? farmList.value : this.farmList));
  }
}

@JsonSerializable(explicitToJson: true)
class FarmResponse$Response {
  const FarmResponse$Response({
    required this.farm,
  });

  factory FarmResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$FarmResponse$ResponseFromJson(json);

  static const toJsonFactory = _$FarmResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$FarmResponse$ResponseToJson(this);

  @JsonKey(name: 'farm')
  final FarmInfoSchema farm;
  static const fromJsonFactory = _$FarmResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FarmResponse$Response &&
            (identical(other.farm, farm) ||
                const DeepCollectionEquality().equals(other.farm, farm)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(farm) ^ runtimeType.hashCode;
}

extension $FarmResponse$ResponseExtension on FarmResponse$Response {
  FarmResponse$Response copyWith({FarmInfoSchema? farm}) {
    return FarmResponse$Response(farm: farm ?? this.farm);
  }

  FarmResponse$Response copyWithWrapped({Wrapped<FarmInfoSchema>? farm}) {
    return FarmResponse$Response(farm: (farm != null ? farm.value : this.farm));
  }
}

@JsonSerializable(explicitToJson: true)
class LatestBlockResponse$Response {
  const LatestBlockResponse$Response({
    required this.block,
  });

  factory LatestBlockResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$LatestBlockResponse$ResponseFromJson(json);

  static const toJsonFactory = _$LatestBlockResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$LatestBlockResponse$ResponseToJson(this);

  @JsonKey(name: 'block')
  final BlockSchema block;
  static const fromJsonFactory = _$LatestBlockResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LatestBlockResponse$Response &&
            (identical(other.block, block) ||
                const DeepCollectionEquality().equals(other.block, block)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(block) ^ runtimeType.hashCode;
}

extension $LatestBlockResponse$ResponseExtension
    on LatestBlockResponse$Response {
  LatestBlockResponse$Response copyWith({BlockSchema? block}) {
    return LatestBlockResponse$Response(block: block ?? this.block);
  }

  LatestBlockResponse$Response copyWithWrapped({Wrapped<BlockSchema>? block}) {
    return LatestBlockResponse$Response(
        block: (block != null ? block.value : this.block));
  }
}

@JsonSerializable(explicitToJson: true)
class MarketListResponse$Response {
  const MarketListResponse$Response({
    required this.pairs,
  });

  factory MarketListResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$MarketListResponse$ResponseFromJson(json);

  static const toJsonFactory = _$MarketListResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$MarketListResponse$ResponseToJson(this);

  @JsonKey(name: 'pairs', defaultValue: <String>[])
  final List<String> pairs;
  static const fromJsonFactory = _$MarketListResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MarketListResponse$Response &&
            (identical(other.pairs, pairs) ||
                const DeepCollectionEquality().equals(other.pairs, pairs)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pairs) ^ runtimeType.hashCode;
}

extension $MarketListResponse$ResponseExtension on MarketListResponse$Response {
  MarketListResponse$Response copyWith({List<String>? pairs}) {
    return MarketListResponse$Response(pairs: pairs ?? this.pairs);
  }

  MarketListResponse$Response copyWithWrapped({Wrapped<List<String>>? pairs}) {
    return MarketListResponse$Response(
        pairs: (pairs != null ? pairs.value : this.pairs));
  }
}

@JsonSerializable(explicitToJson: true)
class OperationStatusResponse$Response {
  const OperationStatusResponse$Response();

  factory OperationStatusResponse$Response.fromJson(
          Map<String, dynamic> json) =>
      _$OperationStatusResponse$ResponseFromJson(json);

  static const toJsonFactory = _$OperationStatusResponse$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$OperationStatusResponse$ResponseToJson(this);

  static const fromJsonFactory = _$OperationStatusResponse$ResponseFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class OperationsResponse$Response {
  const OperationsResponse$Response({
    required this.operations,
  });

  factory OperationsResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$OperationsResponse$ResponseFromJson(json);

  static const toJsonFactory = _$OperationsResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$OperationsResponse$ResponseToJson(this);

  @JsonKey(name: 'operations', defaultValue: <OperationsInfo>[])
  final List<OperationsInfo> operations;
  static const fromJsonFactory = _$OperationsResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OperationsResponse$Response &&
            (identical(other.operations, operations) ||
                const DeepCollectionEquality()
                    .equals(other.operations, operations)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(operations) ^ runtimeType.hashCode;
}

extension $OperationsResponse$ResponseExtension on OperationsResponse$Response {
  OperationsResponse$Response copyWith({List<OperationsInfo>? operations}) {
    return OperationsResponse$Response(
        operations: operations ?? this.operations);
  }

  OperationsResponse$Response copyWithWrapped(
      {Wrapped<List<OperationsInfo>>? operations}) {
    return OperationsResponse$Response(
        operations: (operations != null ? operations.value : this.operations));
  }
}

@JsonSerializable(explicitToJson: true)
class PoolInfoScreenerResponse$Response {
  const PoolInfoScreenerResponse$Response({
    required this.pair,
  });

  factory PoolInfoScreenerResponse$Response.fromJson(
          Map<String, dynamic> json) =>
      _$PoolInfoScreenerResponse$ResponseFromJson(json);

  static const toJsonFactory = _$PoolInfoScreenerResponse$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$PoolInfoScreenerResponse$ResponseToJson(this);

  @JsonKey(name: 'pair')
  final PoolInfoScreenerSchema pair;
  static const fromJsonFactory = _$PoolInfoScreenerResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PoolInfoScreenerResponse$Response &&
            (identical(other.pair, pair) ||
                const DeepCollectionEquality().equals(other.pair, pair)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pair) ^ runtimeType.hashCode;
}

extension $PoolInfoScreenerResponse$ResponseExtension
    on PoolInfoScreenerResponse$Response {
  PoolInfoScreenerResponse$Response copyWith({PoolInfoScreenerSchema? pair}) {
    return PoolInfoScreenerResponse$Response(pair: pair ?? this.pair);
  }

  PoolInfoScreenerResponse$Response copyWithWrapped(
      {Wrapped<PoolInfoScreenerSchema>? pair}) {
    return PoolInfoScreenerResponse$Response(
        pair: (pair != null ? pair.value : this.pair));
  }
}

@JsonSerializable(explicitToJson: true)
class PoolListResponse$Response {
  const PoolListResponse$Response({
    required this.poolList,
  });

  factory PoolListResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$PoolListResponse$ResponseFromJson(json);

  static const toJsonFactory = _$PoolListResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$PoolListResponse$ResponseToJson(this);

  @JsonKey(name: 'pool_list', defaultValue: <PoolInfoSchema>[])
  final List<PoolInfoSchema> poolList;
  static const fromJsonFactory = _$PoolListResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PoolListResponse$Response &&
            (identical(other.poolList, poolList) ||
                const DeepCollectionEquality()
                    .equals(other.poolList, poolList)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(poolList) ^ runtimeType.hashCode;
}

extension $PoolListResponse$ResponseExtension on PoolListResponse$Response {
  PoolListResponse$Response copyWith({List<PoolInfoSchema>? poolList}) {
    return PoolListResponse$Response(poolList: poolList ?? this.poolList);
  }

  PoolListResponse$Response copyWithWrapped(
      {Wrapped<List<PoolInfoSchema>>? poolList}) {
    return PoolListResponse$Response(
        poolList: (poolList != null ? poolList.value : this.poolList));
  }
}

@JsonSerializable(explicitToJson: true)
class PoolResponse$Response {
  const PoolResponse$Response({
    required this.pool,
  });

  factory PoolResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$PoolResponse$ResponseFromJson(json);

  static const toJsonFactory = _$PoolResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$PoolResponse$ResponseToJson(this);

  @JsonKey(name: 'pool')
  final PoolInfoSchema pool;
  static const fromJsonFactory = _$PoolResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PoolResponse$Response &&
            (identical(other.pool, pool) ||
                const DeepCollectionEquality().equals(other.pool, pool)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pool) ^ runtimeType.hashCode;
}

extension $PoolResponse$ResponseExtension on PoolResponse$Response {
  PoolResponse$Response copyWith({PoolInfoSchema? pool}) {
    return PoolResponse$Response(pool: pool ?? this.pool);
  }

  PoolResponse$Response copyWithWrapped({Wrapped<PoolInfoSchema>? pool}) {
    return PoolResponse$Response(pool: (pool != null ? pool.value : this.pool));
  }
}

@JsonSerializable(explicitToJson: true)
class PoolStatsResponse$Response {
  const PoolStatsResponse$Response({
    required this.since,
    required this.stats,
    required this.uniqueWalletsCount,
    required this.until,
  });

  factory PoolStatsResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$PoolStatsResponse$ResponseFromJson(json);

  static const toJsonFactory = _$PoolStatsResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$PoolStatsResponse$ResponseToJson(this);

  @JsonKey(name: 'since')
  final String since;
  @JsonKey(name: 'stats', defaultValue: <PoolStats>[])
  final List<PoolStats> stats;
  @JsonKey(name: 'unique_wallets_count')
  final int uniqueWalletsCount;
  @JsonKey(name: 'until')
  final String until;
  static const fromJsonFactory = _$PoolStatsResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PoolStatsResponse$Response &&
            (identical(other.since, since) ||
                const DeepCollectionEquality().equals(other.since, since)) &&
            (identical(other.stats, stats) ||
                const DeepCollectionEquality().equals(other.stats, stats)) &&
            (identical(other.uniqueWalletsCount, uniqueWalletsCount) ||
                const DeepCollectionEquality()
                    .equals(other.uniqueWalletsCount, uniqueWalletsCount)) &&
            (identical(other.until, until) ||
                const DeepCollectionEquality().equals(other.until, until)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(since) ^
      const DeepCollectionEquality().hash(stats) ^
      const DeepCollectionEquality().hash(uniqueWalletsCount) ^
      const DeepCollectionEquality().hash(until) ^
      runtimeType.hashCode;
}

extension $PoolStatsResponse$ResponseExtension on PoolStatsResponse$Response {
  PoolStatsResponse$Response copyWith(
      {String? since,
      List<PoolStats>? stats,
      int? uniqueWalletsCount,
      String? until}) {
    return PoolStatsResponse$Response(
        since: since ?? this.since,
        stats: stats ?? this.stats,
        uniqueWalletsCount: uniqueWalletsCount ?? this.uniqueWalletsCount,
        until: until ?? this.until);
  }

  PoolStatsResponse$Response copyWithWrapped(
      {Wrapped<String>? since,
      Wrapped<List<PoolStats>>? stats,
      Wrapped<int>? uniqueWalletsCount,
      Wrapped<String>? until}) {
    return PoolStatsResponse$Response(
        since: (since != null ? since.value : this.since),
        stats: (stats != null ? stats.value : this.stats),
        uniqueWalletsCount: (uniqueWalletsCount != null
            ? uniqueWalletsCount.value
            : this.uniqueWalletsCount),
        until: (until != null ? until.value : this.until));
  }
}

@JsonSerializable(explicitToJson: true)
class SimulateSwapResponse$Response {
  const SimulateSwapResponse$Response({
    required this.askAddress,
    required this.askJettonWallet,
    required this.askUnits,
    required this.feeAddress,
    required this.feePercent,
    required this.feeUnits,
    required this.minAskUnits,
    required this.offerAddress,
    required this.offerJettonWallet,
    required this.offerUnits,
    required this.poolAddress,
    required this.priceImpact,
    required this.routerAddress,
    required this.slippageTolerance,
    required this.swapRate,
  });

  factory SimulateSwapResponse$Response.fromJson(Map<String, dynamic> json) =>
      _$SimulateSwapResponse$ResponseFromJson(json);

  static const toJsonFactory = _$SimulateSwapResponse$ResponseToJson;
  Map<String, dynamic> toJson() => _$SimulateSwapResponse$ResponseToJson(this);

  @JsonKey(name: 'ask_address')
  final String askAddress;
  @JsonKey(name: 'ask_jetton_wallet')
  final String askJettonWallet;
  @JsonKey(name: 'ask_units')
  final String askUnits;
  @JsonKey(name: 'fee_address')
  final String feeAddress;
  @JsonKey(name: 'fee_percent')
  final String feePercent;
  @JsonKey(name: 'fee_units')
  final String feeUnits;
  @JsonKey(name: 'min_ask_units')
  final String minAskUnits;
  @JsonKey(name: 'offer_address')
  final String offerAddress;
  @JsonKey(name: 'offer_jetton_wallet')
  final String offerJettonWallet;
  @JsonKey(name: 'offer_units')
  final String offerUnits;
  @JsonKey(name: 'pool_address')
  final String poolAddress;
  @JsonKey(name: 'price_impact')
  final String priceImpact;
  @JsonKey(name: 'router_address')
  final String routerAddress;
  @JsonKey(name: 'slippage_tolerance')
  final String slippageTolerance;
  @JsonKey(name: 'swap_rate')
  final String swapRate;
  static const fromJsonFactory = _$SimulateSwapResponse$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SimulateSwapResponse$Response &&
            (identical(other.askAddress, askAddress) ||
                const DeepCollectionEquality()
                    .equals(other.askAddress, askAddress)) &&
            (identical(other.askJettonWallet, askJettonWallet) ||
                const DeepCollectionEquality()
                    .equals(other.askJettonWallet, askJettonWallet)) &&
            (identical(other.askUnits, askUnits) ||
                const DeepCollectionEquality()
                    .equals(other.askUnits, askUnits)) &&
            (identical(other.feeAddress, feeAddress) ||
                const DeepCollectionEquality()
                    .equals(other.feeAddress, feeAddress)) &&
            (identical(other.feePercent, feePercent) ||
                const DeepCollectionEquality()
                    .equals(other.feePercent, feePercent)) &&
            (identical(other.feeUnits, feeUnits) ||
                const DeepCollectionEquality()
                    .equals(other.feeUnits, feeUnits)) &&
            (identical(other.minAskUnits, minAskUnits) ||
                const DeepCollectionEquality()
                    .equals(other.minAskUnits, minAskUnits)) &&
            (identical(other.offerAddress, offerAddress) ||
                const DeepCollectionEquality()
                    .equals(other.offerAddress, offerAddress)) &&
            (identical(other.offerJettonWallet, offerJettonWallet) ||
                const DeepCollectionEquality()
                    .equals(other.offerJettonWallet, offerJettonWallet)) &&
            (identical(other.offerUnits, offerUnits) ||
                const DeepCollectionEquality()
                    .equals(other.offerUnits, offerUnits)) &&
            (identical(other.poolAddress, poolAddress) ||
                const DeepCollectionEquality()
                    .equals(other.poolAddress, poolAddress)) &&
            (identical(other.priceImpact, priceImpact) ||
                const DeepCollectionEquality()
                    .equals(other.priceImpact, priceImpact)) &&
            (identical(other.routerAddress, routerAddress) ||
                const DeepCollectionEquality()
                    .equals(other.routerAddress, routerAddress)) &&
            (identical(other.slippageTolerance, slippageTolerance) ||
                const DeepCollectionEquality()
                    .equals(other.slippageTolerance, slippageTolerance)) &&
            (identical(other.swapRate, swapRate) ||
                const DeepCollectionEquality()
                    .equals(other.swapRate, swapRate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(askAddress) ^
      const DeepCollectionEquality().hash(askJettonWallet) ^
      const DeepCollectionEquality().hash(askUnits) ^
      const DeepCollectionEquality().hash(feeAddress) ^
      const DeepCollectionEquality().hash(feePercent) ^
      const DeepCollectionEquality().hash(feeUnits) ^
      const DeepCollectionEquality().hash(minAskUnits) ^
      const DeepCollectionEquality().hash(offerAddress) ^
      const DeepCollectionEquality().hash(offerJettonWallet) ^
      const DeepCollectionEquality().hash(offerUnits) ^
      const DeepCollectionEquality().hash(poolAddress) ^
      const DeepCollectionEquality().hash(priceImpact) ^
      const DeepCollectionEquality().hash(routerAddress) ^
      const DeepCollectionEquality().hash(slippageTolerance) ^
      const DeepCollectionEquality().hash(swapRate) ^
      runtimeType.hashCode;
}

extension $SimulateSwapResponse$ResponseExtension
    on SimulateSwapResponse$Response {
  SimulateSwapResponse$Response copyWith(
      {String? askAddress,
      String? askJettonWallet,
      String? askUnits,
      String? feeAddress,
      String? feePercent,
      String? feeUnits,
      String? minAskUnits,
      String? offerAddress,
      String? offerJettonWallet,
      String? offerUnits,
      String? poolAddress,
      String? priceImpact,
      String? routerAddress,
      String? slippageTolerance,
      String? swapRate}) {
    return SimulateSwapResponse$Response(
        askAddress: askAddress ?? this.askAddress,
        askJettonWallet: askJettonWallet ?? this.askJettonWallet,
        askUnits: askUnits ?? this.askUnits,
        feeAddress: feeAddress ?? this.feeAddress,
        feePercent: feePercent ?? this.feePercent,
        feeUnits: feeUnits ?? this.feeUnits,
        minAskUnits: minAskUnits ?? this.minAskUnits,
        offerAddress: offerAddress ?? this.offerAddress,
        offerJettonWallet: offerJettonWallet ?? this.offerJettonWallet,
        offerUnits: offerUnits ?? this.offerUnits,
        poolAddress: poolAddress ?? this.poolAddress,
        priceImpact: priceImpact ?? this.priceImpact,
        routerAddress: routerAddress ?? this.routerAddress,
        slippageTolerance: slippageTolerance ?? this.slippageTolerance,
        swapRate: swapRate ?? this.swapRate);
  }

  SimulateSwapResponse$Response copyWithWrapped(
      {Wrapped<String>? askAddress,
      Wrapped<String>? askJettonWallet,
      Wrapped<String>? askUnits,
      Wrapped<String>? feeAddress,
      Wrapped<String>? feePercent,
      Wrapped<String>? feeUnits,
      Wrapped<String>? minAskUnits,
      Wrapped<String>? offerAddress,
      Wrapped<String>? offerJettonWallet,
      Wrapped<String>? offerUnits,
      Wrapped<String>? poolAddress,
      Wrapped<String>? priceImpact,
      Wrapped<String>? routerAddress,
      Wrapped<String>? slippageTolerance,
      Wrapped<String>? swapRate}) {
    return SimulateSwapResponse$Response(
        askAddress: (askAddress != null ? askAddress.value : this.askAddress),
        askJettonWallet: (askJettonWallet != null
            ? askJettonWallet.value
            : this.askJettonWallet),
        askUnits: (askUnits != null ? askUnits.value : this.askUnits),
        feeAddress: (feeAddress != null ? feeAddress.value : this.feeAddress),
        feePercent: (feePercent != null ? feePercent.value : this.feePercent),
        feeUnits: (feeUnits != null ? feeUnits.value : this.feeUnits),
        minAskUnits:
            (minAskUnits != null ? minAskUnits.value : this.minAskUnits),
        offerAddress:
            (offerAddress != null ? offerAddress.value : this.offerAddress),
        offerJettonWallet: (offerJettonWallet != null
            ? offerJettonWallet.value
            : this.offerJettonWallet),
        offerUnits: (offerUnits != null ? offerUnits.value : this.offerUnits),
        poolAddress:
            (poolAddress != null ? poolAddress.value : this.poolAddress),
        priceImpact:
            (priceImpact != null ? priceImpact.value : this.priceImpact),
        routerAddress:
            (routerAddress != null ? routerAddress.value : this.routerAddress),
        slippageTolerance: (slippageTolerance != null
            ? slippageTolerance.value
            : this.slippageTolerance),
        swapRate: (swapRate != null ? swapRate.value : this.swapRate));
  }
}

String? assetKindSchemaNullableToJson(enums.AssetKindSchema? assetKindSchema) {
  return assetKindSchema?.value;
}

String? assetKindSchemaToJson(enums.AssetKindSchema assetKindSchema) {
  return assetKindSchema.value;
}

enums.AssetKindSchema assetKindSchemaFromJson(
  Object? assetKindSchema, [
  enums.AssetKindSchema? defaultValue,
]) {
  return enums.AssetKindSchema.values
          .firstWhereOrNull((e) => e.value == assetKindSchema) ??
      defaultValue ??
      enums.AssetKindSchema.swaggerGeneratedUnknown;
}

enums.AssetKindSchema? assetKindSchemaNullableFromJson(
  Object? assetKindSchema, [
  enums.AssetKindSchema? defaultValue,
]) {
  if (assetKindSchema == null) {
    return null;
  }
  return enums.AssetKindSchema.values
          .firstWhereOrNull((e) => e.value == assetKindSchema) ??
      defaultValue;
}

String assetKindSchemaExplodedListToJson(
    List<enums.AssetKindSchema>? assetKindSchema) {
  return assetKindSchema?.map((e) => e.value!).join(',') ?? '';
}

List<String> assetKindSchemaListToJson(
    List<enums.AssetKindSchema>? assetKindSchema) {
  if (assetKindSchema == null) {
    return [];
  }

  return assetKindSchema.map((e) => e.value!).toList();
}

List<enums.AssetKindSchema> assetKindSchemaListFromJson(
  List? assetKindSchema, [
  List<enums.AssetKindSchema>? defaultValue,
]) {
  if (assetKindSchema == null) {
    return defaultValue ?? [];
  }

  return assetKindSchema
      .map((e) => assetKindSchemaFromJson(e.toString()))
      .toList();
}

List<enums.AssetKindSchema>? assetKindSchemaNullableListFromJson(
  List? assetKindSchema, [
  List<enums.AssetKindSchema>? defaultValue,
]) {
  if (assetKindSchema == null) {
    return defaultValue;
  }

  return assetKindSchema
      .map((e) => assetKindSchemaFromJson(e.toString()))
      .toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
