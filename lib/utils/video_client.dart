//Third Party Imports
import 'dart:convert';
import 'package:http/http.dart' as http;

class VideoClient {
  final http.Client _client;

  VideoClient({http.Client? client}) : _client = client ?? http.Client();

  static const muxStreamBaseUrl = 'https://stream.mux.com';

  static const videoExtension = '.m3u8';

  Future<Map<String, dynamic>> getMuxAssets() async {
    const muxTokenId = '0f807b52-2035-4907-852b-37fee5382afc';
    const muxSecretKey = "7xfsSMxw+F8GffGOv+97qK4xpZ6z9dDS8K1ToVFx03OQOreQpAOmc9OEvweyzF9aOU8I0g7k3Ye";

    final response = await _client.get(
        Uri.parse('https://api.mux.com/video/v1/assets'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$muxTokenId:$muxSecretKey'))}',
        });

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load assets');
    }
  }

  Future<Map<String, dynamic>> getMuxAsset(String assetId) async {
    const muxTokenId = '0f807b52-2035-4907-852b-37fee5382afc';
    const muxSecretKey = "7xfsSMxw+F8GffGOv+97qK4xpZ6z9dDS8K1ToVFx03OQOreQpAOmc9OEvweyzF9aOU8I0g7k3Ye";

    final response = await _client.get(
        Uri.parse('https://api.mux.com/video/v1/assets/$assetId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$muxTokenId:$muxSecretKey'))}',
        });

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load the asset from MUX');
    }
  }
}