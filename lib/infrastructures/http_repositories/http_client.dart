import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  Future<Map<String, dynamic>> post(
      Uri url, Map<String, String> headers, Map<String, dynamic> body) async {
    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode != 200) {
      throw Exception('postリクエストに失敗しました。');
    }

    final Map<String, dynamic> responseBody =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    return responseBody;
  }
}
