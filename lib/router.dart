import 'package:bottom_sheet_routing/bottom_sheet_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BottomSheetPage(
        modalIndex: int.tryParse(state.queryParams['index'] ?? ''),
      ),
    ),
  ],
);
