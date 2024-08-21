import 'package:feature_navigator/feature_route.dart';

class RouteInfoProvider {
  final List<FeatureRoute> routes;

  RouteInfoProvider({required this.routes});

  List<Map<String, String>> getRoutesInfo() {
    return routes.map((route) {
      return {
        'name': route.name ?? 'Unnamed Route',
        'description': route.description,
        'path': route.path,
      };
    }).toList();
  }

  String getRouteDescription(String routeName) {
    final route = routes.firstWhere(
      (route) => route.name == routeName,
      orElse: () => throw Exception('Route not found'),
    );

    return 'Route "${route.name}" points to the path "${route.path}". Description: "${route.description}".';
  }
}
