import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatApiService {
  Future<String> fetchMessage() async {
    final res =
    await http.get(Uri.parse('https://api.quotable.io/random'));
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['content'];
    }
    return "Hello 👋";
  }
}
