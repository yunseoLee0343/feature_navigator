import 'package:go_router/go_router.dart';

class FeatureRoute extends GoRoute {
  final String description;

  FeatureRoute({
    required this.description,
    required super.path,
    required super.builder,
    super.name,
    super.pageBuilder,
    super.redirect,
    super.routes = const <RouteBase>[],
  });
}
