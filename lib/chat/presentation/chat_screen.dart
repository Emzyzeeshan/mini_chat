import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/message_model.dart';
import '../data/chat_api_service.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/bloc/home_event.dart';

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

  void send() async {
    if (_controller.text.isEmpty) return;

    final text = _controller.text;
    setState(() {
      _messages.add(MessageModel(text: text, isSender: true));
    });
    context.read<HomeBloc>().add(UpdateChatHistory(widget.userIndex, text));
    _controller.clear();

    final reply = await _api.fetchMessage();
    setState(() {
      _messages.add(MessageModel(text: reply, isSender: false));
    });
    context.read<HomeBloc>().add(UpdateChatHistory(widget.userIndex, reply));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                return Align(
                  alignment:
                  m.isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: m.isSender ? Colors.blue : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      m.text,
                      style: TextStyle(
                        color: m.isSender ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(controller: _controller),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: send,
              )
            ],
          )
        ],
      ),
    );
  }
}
