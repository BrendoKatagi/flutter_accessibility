import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

Matcher hasOneAnnouncement(AnnounceSemanticsEvent event) {
  return _HasSemanticsAnnouncementMatcher(<AnnounceSemanticsEvent>[event]);
}

Matcher hasNAnnouncements(List<AnnounceSemanticsEvent> events) {
  return _HasSemanticsAnnouncementMatcher(events);
}

Matcher hasZeroAnnouncements() {
  return const _HasSemanticsAnnouncementMatcher(<AnnounceSemanticsEvent>[]);
}

class _HasSemanticsAnnouncementMatcher extends Matcher {
  final List<AnnounceSemanticsEvent> expectedEvents;

  const _HasSemanticsAnnouncementMatcher(this.expectedEvents);

  @override
  Description describe(Description description) {
    if (expectedEvents.isEmpty) {
      return description.add('Zero announcements');
    }
    return description.add(expectedEvents.toString());
  }

  @override
  bool matches(covariant List<AnnounceSemanticsEvent> events, Map<dynamic, dynamic> matchState) {
    if (expectedEvents.length != events.length) {
      return false;
    }
    for (int i = 0; i < expectedEvents.length - 1; i++) {
      if (!mapEquals(expectedEvents[i].getDataMap(), events[i].getDataMap())) {
        return false;
      }
    }
    return true;
  }
}
