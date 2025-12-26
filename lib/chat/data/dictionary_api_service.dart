import 'dart:convert';
import 'package:http/http.dart' as http;

class DictionaryApiService {
  Future<String> getMeaning(String word) async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.dictionaryapi.dev/api/v2/entries/en/$word',
        ),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data[0]['meanings'][0]['definitions'][0]['definition'];
      }
      return "Meaning not found.";
    } catch (_) {
      return "Unable to fetch meaning.";
    }
  }
}
