import 'package:financialweb/pages/event_details_page.dart';
import 'package:financialweb/pages/login_page.dart';
import 'package:financialweb/pages/signup_page.dart';
import 'package:go_router/go_router.dart';

import 'pages/events_page.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
      name: 'login'),
  GoRoute(
      path: '/events',
      name: 'eventos',
      builder: (context, state) => const EventsPage(),
      routes: [
        GoRoute(
            path: ':eventIndex',
            name: 'event-details',
            builder: (context, state) {
              int id = int.parse(state.params['eventIndex'] as String);
              
              return EventDetailsPage(id: id);
            })
      ]),
  GoRoute(path: '/', builder: (context, state) => const LoginPage(), routes: [
    GoRoute(
      path: 'signup',
      name: 'cadastre-se',
      builder: (context, state) => const SignUpPage(),
    )
  ]),
]);
