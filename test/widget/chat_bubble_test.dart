import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_chat/core/widgets/chat_bubble.dart';

void main() {
  testWidgets('Sender chat bubble shows text', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ChatBubble(
            text: 'Hello',
            isSender: true,
            avatar: 'Y',
          ),
        ),
      ),
    );

    expect(find.text('Hello'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });

  testWidgets('Receiver chat bubble shows text', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ChatBubble(
            text: 'Hi there',
            isSender: false,
            avatar: 'A',
          ),
        ),
      ),
    );

    expect(find.text('Hi there'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}
