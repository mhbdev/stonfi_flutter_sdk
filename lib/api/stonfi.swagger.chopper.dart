// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stonfi.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Stonfi extends Stonfi {
  _$Stonfi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Stonfi;

  @override
  Future<Response<List<Object>>> _exportCmcV1Get() {
    final Uri $url = Uri.parse('/export/cmc/v1');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Object>, Object>($request);
  }

  @override
  Future<Response<AssetInfoScreenerResponse$Response>>
      _exportDexscreenerV1AssetAddressGet({required String? address}) {
    final Uri $url = Uri.parse('/export/dexscreener/v1/asset/${address}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<AssetInfoScreenerResponse$Response,
        AssetInfoScreenerResponse$Response>($request);
  }

  @override
  Future<Response<EventsResponse$Response>> _exportDexscreenerV1EventsGet({
    required int? fromBlock,
    required int? toBlock,
  }) {
    final Uri $url = Uri.parse('/export/dexscreener/v1/events');
    final Map<String, dynamic> $params = <String, dynamic>{
      'fromBlock': fromBlock,
      'toBlock': toBlock,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<EventsResponse$Response, EventsResponse$Response>($request);
  }

  @override
  Future<Response<LatestBlockResponse$Response>>
      _exportDexscreenerV1LatestBlockGet() {
    final Uri $url = Uri.parse('/export/dexscreener/v1/latest-block');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<LatestBlockResponse$Response,
        LatestBlockResponse$Response>($request);
  }

  @override
  Future<Response<PoolInfoScreenerResponse$Response>>
      _exportDexscreenerV1PairAddressGet({required String? address}) {
    final Uri $url = Uri.parse('/export/dexscreener/v1/pair/${address}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PoolInfoScreenerResponse$Response,
        PoolInfoScreenerResponse$Response>($request);
  }

  @override
  Future<Response<AssetListResponse$Response>> _v1AssetsGet() {
    final Uri $url = Uri.parse('/v1/assets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<AssetListResponse$Response, AssetListResponse$Response>($request);
  }

  @override
  Future<Response<AssetListResponseV2$Response>> _v1AssetsQueryPost({
    String? condition,
    List<String>? unconditionalAssets,
    String? walletAddress,
  }) {
    final Uri $url = Uri.parse('/v1/assets/query');
    final Map<String, dynamic> $params = <String, dynamic>{
      'condition': condition,
      'unconditional_assets': unconditionalAssets,
      'wallet_address': walletAddress,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AssetListResponseV2$Response,
        AssetListResponseV2$Response>($request);
  }

  @override
  Future<Response<AssetListResponseV2$Response>> _v1AssetsSearchPost({
    required String? searchString,
    String? condition,
    String? walletAddress,
  }) {
    final Uri $url = Uri.parse('/v1/assets/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'search_string': searchString,
      'condition': condition,
      'wallet_address': walletAddress,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AssetListResponseV2$Response,
        AssetListResponseV2$Response>($request);
  }

  @override
  Future<Response<AssetResponse$Response>> _v1AssetsAddrStrGet(
      {required String? addrStr}) {
    final Uri $url = Uri.parse('/v1/assets/${addrStr}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<AssetResponse$Response, AssetResponse$Response>($request);
  }

  @override
  Future<Response<FarmListResponse$Response>> _v1FarmsGet() {
    final Uri $url = Uri.parse('/v1/farms');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<FarmListResponse$Response, FarmListResponse$Response>($request);
  }

  @override
  Future<Response<FarmResponse$Response>> _v1FarmsAddrStrGet(
      {required String? addrStr}) {
    final Uri $url = Uri.parse('/v1/farms/${addrStr}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<FarmResponse$Response, FarmResponse$Response>($request);
  }

  @override
  Future<Response<FarmListResponse$Response>> _v1FarmsByPoolPoolAddrStrGet(
      {required String? poolAddrStr}) {
    final Uri $url = Uri.parse('/v1/farms_by_pool/${poolAddrStr}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<FarmListResponse$Response, FarmListResponse$Response>($request);
  }

  @override
  Future<Response<AddressResponse$Response>> _v1JettonAddrStrAddressGet({
    required String? ownerAddress,
    required String? addrStr,
  }) {
    final Uri $url = Uri.parse('/v1/jetton/${addrStr}/address');
    final Map<String, dynamic> $params = <String, dynamic>{
      'owner_address': ownerAddress
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<AddressResponse$Response, AddressResponse$Response>($request);
  }

  @override
  Future<Response<MarketListResponse$Response>> _v1MarketsGet() {
    final Uri $url = Uri.parse('/v1/markets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MarketListResponse$Response,
        MarketListResponse$Response>($request);
  }

  @override
  Future<Response<PoolListResponse$Response>> _v1PoolsGet() {
    final Uri $url = Uri.parse('/v1/pools');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<PoolListResponse$Response, PoolListResponse$Response>($request);
  }

  @override
  Future<Response<PoolListResponse$Response>> _v1PoolsAddrStrGet(
      {required String? addrStr}) {
    final Uri $url = Uri.parse('/v1/pools/${addrStr}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<PoolListResponse$Response, PoolListResponse$Response>($request);
  }

  @override
  Future<Response<SimulateSwapResponse$Response>> _v1ReverseSwapSimulatePost({
    required String? offerAddress,
    required String? askAddress,
    required String? units,
    required String? slippageTolerance,
    String? referralAddress,
  }) {
    final Uri $url = Uri.parse('/v1/reverse_swap/simulate');
    final Map<String, dynamic> $params = <String, dynamic>{
      'offer_address': offerAddress,
      'ask_address': askAddress,
      'units': units,
      'slippage_tolerance': slippageTolerance,
      'referral_address': referralAddress,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SimulateSwapResponse$Response,
        SimulateSwapResponse$Response>($request);
  }

  @override
  Future<Response<DexStatsResponse$Response>> _v1StatsDexGet({
    String? since,
    String? until,
  }) {
    final Uri $url = Uri.parse('/v1/stats/dex');
    final Map<String, dynamic> $params = <String, dynamic>{
      'since': since,
      'until': until,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<DexStatsResponse$Response, DexStatsResponse$Response>($request);
  }

  @override
  Future<Response<OperationsResponse$Response>> _v1StatsOperationsGet({
    required String? since,
    required String? until,
  }) {
    final Uri $url = Uri.parse('/v1/stats/operations');
    final Map<String, dynamic> $params = <String, dynamic>{
      'since': since,
      'until': until,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<OperationsResponse$Response,
        OperationsResponse$Response>($request);
  }

  @override
  Future<Response<PoolStatsResponse$Response>> _v1StatsPoolGet({
    required String? since,
    required String? until,
  }) {
    final Uri $url = Uri.parse('/v1/stats/pool');
    final Map<String, dynamic> $params = <String, dynamic>{
      'since': since,
      'until': until,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<PoolStatsResponse$Response, PoolStatsResponse$Response>($request);
  }

  @override
  Future<Response<SimulateSwapResponse$Response>> _v1SwapSimulatePost({
    required String? offerAddress,
    required String? askAddress,
    required String? units,
    required String? slippageTolerance,
    String? referralAddress,
  }) {
    final Uri $url = Uri.parse('/v1/swap/simulate');
    final Map<String, dynamic> $params = <String, dynamic>{
      'offer_address': offerAddress,
      'ask_address': askAddress,
      'units': units,
      'slippage_tolerance': slippageTolerance,
      'referral_address': referralAddress,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SimulateSwapResponse$Response,
        SimulateSwapResponse$Response>($request);
  }

  @override
  Future<Response<Object>> _v1SwapStatusGet({
    required String? routerAddress,
    required String? ownerAddress,
    required String? queryId,
  }) {
    final Uri $url = Uri.parse('/v1/swap/status');
    final Map<String, dynamic> $params = <String, dynamic>{
      'router_address': routerAddress,
      'owner_address': ownerAddress,
      'query_id': queryId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Object, Object>($request);
  }

  @override
  Future<Response<AssetListResponse$Response>> _v1WalletsAddrStrAssetsGet(
      {required String? addrStr}) {
    final Uri $url = Uri.parse('/v1/wallets/${addrStr}/assets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<AssetListResponse$Response, AssetListResponse$Response>($request);
  }

  @override
  Future<Response<AssetResponse$Response>> _v1WalletsAddrStrAssetsAssetStrGet({
    required String? addrStr,
    required String? assetStr,
  }) {
    final Uri $url = Uri.parse('/v1/wallets/${addrStr}/assets/${assetStr}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<AssetResponse$Response, AssetResponse$Response>($request);
  }

  @override
  Future<Response<FarmListResponse$Response>> _v1WalletsAddrStrFarmsGet(
      {required String? addrStr}) {
    final Uri $url = Uri.parse('/v1/wallets/${addrStr}/farms');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<FarmListResponse$Response, FarmListResponse$Response>($request);
  }

  @override
  Future<Response<FarmResponse$Response>> _v1WalletsAddrStrFarmsFarmStrGet({
    required String? addrStr,
    required String? farmStr,
  }) {
    final Uri $url = Uri.parse('/v1/wallets/${addrStr}/farms/${farmStr}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<FarmResponse$Response, FarmResponse$Response>($request);
  }

  @override
  Future<Response<OperationsResponse$Response>> _v1WalletsAddrStrOperationsGet({
    required String? since,
    required String? until,
    String? opType,
    required String? addrStr,
  }) {
    final Uri $url = Uri.parse('/v1/wallets/${addrStr}/operations');
    final Map<String, dynamic> $params = <String, dynamic>{
      'since': since,
      'until': until,
      'op_type': opType,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<OperationsResponse$Response,
        OperationsResponse$Response>($request);
  }

  @override
  Future<Response<PoolListResponse$Response>> _v1WalletsAddrStrPoolsGet(
      {required String? addrStr}) {
    final Uri $url = Uri.parse('/v1/wallets/${addrStr}/pools');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<PoolListResponse$Response, PoolListResponse$Response>($request);
  }

  @override
  Future<Response<PoolResponse$Response>> _v1WalletsAddrStrPoolsPoolStrGet({
    required String? addrStr,
    required String? poolStr,
  }) {
    final Uri $url = Uri.parse('/v1/wallets/${addrStr}/pools/${poolStr}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PoolResponse$Response, PoolResponse$Response>($request);
  }
}
