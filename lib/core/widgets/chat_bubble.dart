import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final String avatar;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isSender,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor =
    isSender ? Colors.blue : Colors.grey.shade200;
    final textColor =
    isSender ? Colors.white : Colors.black87;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment:
        isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isSender) _Avatar(avatar),

          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              margin: EdgeInsets.only(
                left: isSender ? 40 : 8,
                right: isSender ? 8 : 40,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft:
                  isSender ? const Radius.circular(16) : Radius.zero,
                  bottomRight:
                  isSender ? Radius.zero : const Radius.circular(16),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),

          if (isSender) _Avatar(avatar),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String text;
  const _Avatar(this.text);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: Colors.blueAccent,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
