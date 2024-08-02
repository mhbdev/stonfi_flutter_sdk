import 'dart:convert';
import 'dart:typed_data';

extension Uint8ListExt on Uint8List {
  String toBase64() {
    return base64Encode(this);
  }
}