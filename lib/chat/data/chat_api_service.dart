import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatApiService {
  Future<String> fetchMessage() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://jsonplaceholder.typicode.com/comments/1',
        ),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['body'] ?? "Hello 👋";
      }
      return "No reply received.";
    } catch (_) {
      // 🔥 graceful fallback (NO CRASH)
      return "I'm offline right now 😊";
    }
  }
}
