import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum AssetKindSchema {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Jetton')
  jetton('Jetton'),
  @JsonValue('Wton')
  wton('Wton'),
  @JsonValue('Ton')
  ton('Ton'),
  @JsonValue('NotAnAsset')
  notanasset('NotAnAsset');

  final String? value;

  const AssetKindSchema(this.value);
}
