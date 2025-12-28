import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/widgets/chat_bubble.dart';
import '../../features/home/bloc/home_bloc.dart';
import '../../features/home/bloc/home_event.dart';
import '../data/dictionary_api_service.dart';
import '../models/message_model.dart';
import '../data/chat_api_service.dart';

class ChatScreen extends StatefulWidget {
  final int userIndex;
  const ChatScreen({super.key, required this.userIndex});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _api = ChatApiService();
  final List<MessageModel> _messages = [];
  final _dictionaryApi = DictionaryApiService();

  void _showMeaningBottomSheet(BuildContext context, String word) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return FutureBuilder<String>(
          future: _dictionaryApi.getMeaning(word),
          builder: (_, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child:
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            word.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(snapshot.data ?? "No meaning found"),
                        ],
                      ),
            );
          },
        );
      },
    );
  }

  void send() async {
    if (_controller.text.trim().isEmpty) return;

    final text = _controller.text.trim();

    setState(() {
      _messages.add(MessageModel(text: text, isSender: true));
    });

    context.read<HomeBloc>().add(UpdateChatHistory(widget.userIndex, text));

    _controller.clear();

    String reply;

    try {
      reply = await _api.fetchMessage();
    } catch (_) {
      reply = "Unable to reply right now 🙂";
    }

    setState(() {
      _messages.add(MessageModel(text: reply, isSender: false));
    });

    context.read<HomeBloc>().add(UpdateChatHistory(widget.userIndex, reply));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];

                return GestureDetector(
                  onLongPress: () {
                    final words = m.text.split(' ');
                    if (words.isNotEmpty) {
                      _showMeaningBottomSheet(context, words.first);
                    }
                  },
                  child: ChatBubble(
                    text: m.text,
                    isSender: m.isSender,
                    avatar: m.isSender ? "Y" : "A",
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: send,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
