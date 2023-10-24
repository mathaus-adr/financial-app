import 'package:financialweb/pages/create_account_page.dart';
import 'package:financialweb/pages/event_details_page.dart';
import 'package:financialweb/pages/login_page.dart';
import 'package:go_router/go_router.dart';

import 'pages/events_page.dart';

final router = GoRouter(initialLocation: '/events', routes: [
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(path: '/events', builder: (context, state) => const EventsPage()),
  GoRoute(
      path: '/events/:eventIndex',
      name: 'event-details',
      builder: (context, state) {
        return const EventDetailsPage();
      }),
  GoRoute(
    path: '/  ',
    builder: (context, state) => const CreateAccountPage(),
  )
]);
