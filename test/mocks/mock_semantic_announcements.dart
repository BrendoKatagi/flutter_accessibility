import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSemanticAnnouncements {
  final List<AnnounceSemanticsEvent> _messages = <AnnounceSemanticsEvent>[];

  List<AnnounceSemanticsEvent> get announcements => _messages;

  MockSemanticAnnouncements(WidgetTester tester) {
    _setMockMessageHandler(tester);
  }

  void _setMockMessageHandler(WidgetTester tester) {
    Future<dynamic> handleMessage(dynamic mockMessage) async {
      final Map<dynamic, dynamic> message = mockMessage as Map<dynamic, dynamic>;
      if (message['type'] == 'announce') {
        _messages.add(
          AnnounceSemanticsEvent(
            message['data']['message'],
            TextDirection.values[message['data']['textDirection']],
          ),
        );
      }
    }

    tester.binding.defaultBinaryMessenger.setMockDecodedMessageHandler(SystemChannels.accessibility, handleMessage);
  }
}
