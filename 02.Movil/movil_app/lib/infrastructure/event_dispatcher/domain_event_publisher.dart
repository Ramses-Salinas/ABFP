import '../../domain/events/domain_event.dart';

class DomainEventPublisher {
  static final DomainEventPublisher _instance = DomainEventPublisher._internal();
  DomainEventPublisher._internal();

  static DomainEventPublisher get instance => _instance;

  final List<Function(DomainEvent)> _subscribers = [];

  void subscribe(Function(DomainEvent) handler) {
    _subscribers.add(handler);
  }

  void publish(DomainEvent event) {
    for (var subscriber in _subscribers) {
      subscriber(event);
    }
  }
}
