import 'package:stonfi/api/client_index.dart';
import 'package:stonfi/client/client.dart';
import 'package:stonfi/contracts/dex/v1/router_v1.dart';
import 'package:tonutils/dataformat.dart';

Future<void> main() async {
  final api = StonfiApi.create();
  // call methods of stonfi api easily using the api object above
  // Like getting list of markets => api.v1MarketsGet();

  final client = Client();
  final dexRouter = client.open(RouterV1());
  await dexRouter.getSwapJettonToJettonTxParams(
    userWalletAddress: address('<-User Wallet Address->'),
    askJettonAddress: address('<-Ask Jetton Address->'),
    offerJettonAddress: address('<-Offer Jetton Address->'),
    offerAmount: BigInt.two,
    minAskAmount: BigInt.one,
  );
  // send arguments => params.to, params.body, params.value
}
