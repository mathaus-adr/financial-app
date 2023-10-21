import 'package:go_router/go_router.dart';

import 'pages/events_page.dart';

final router = GoRouter(initialLocation: '/events', routes: [
  GoRoute(path: '/events',
   builder: (context, state) => const EventsPage()
   ),
  // GoRoute(
  //     path: 'events/:eventId',
  //     builder: (context, state) {
  //       return EventDetailsPage(eventId: state.params['eventId']);
  //     }),
]);

class EventDetailsPage {
}
