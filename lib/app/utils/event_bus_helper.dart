import 'package:event_bus/event_bus.dart';

/// A centralized EventBus instance to be used throughout the app.
/// This prevents creating multiple instances and ensures a single
/// point of event communication.
class EventBusHelper {
  static final EventBus _eventBus = EventBus();

  static EventBus get instance => _eventBus;
}

// --- Example Events ---
// You can define specific event classes to carry data.

/// Fired when user profile is updated.
class ProfileUpdatedEvent {
  final String newName;
  ProfileUpdatedEvent(this.newName);
}

/// Fired when a user successfully logs out.
class UserLoggedOutEvent {}

class NavigationEvent {
  final int pageIndex;

  NavigationEvent(this.pageIndex);
}
