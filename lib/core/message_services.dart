import 'package:flutter_event_bus/flutter_event_bus.dart';

enum MessageType {
  WatchlistChange,
  // TODO
  Logout,
}

class MessageEvent<T> {
  MessageEvent({required this.type, this.data});
  MessageType type;
  T? data;
}

class MessageCenter {
  final eventBus = EventBus();

  void publishMessage(MessageEvent message) {
    eventBus.publish(message);
  }

  /// You must be handle Subscription dispose to unsubscribe
  /// Subscription.dispose()
  Subscription subscribe(Function(MessageEvent) callback) {
    return eventBus.respond<MessageEvent>((event) {
      callback(event);
    });
  }
}
