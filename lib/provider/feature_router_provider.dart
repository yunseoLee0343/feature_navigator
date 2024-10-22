import 'package:feature_navigator/feature_router.dart';
import 'package:feature_navigator/model/feature_router.dart';
import 'package:go_router/go_router.dart';

class RouteDataProvider {
  static final Map<String, FeatureRouteData> _routeDataMap = {};

  static void initializeRoutes(List<RouteBase> routes) {
    _routeDataMap.clear();
    _traverseRoutes(routes, '', _routeDataMap);
  }

  static List<String> getAllRouteNames() => _routeDataMap.keys.toList();

  static String? getRouteDescription(String name) =>
      _routeDataMap[name]?.description;

  static String? getFullPath(String name) => _routeDataMap[name]?.fullPath;

  static void _traverseRoutes(
    List<RouteBase> routes,
    String parentPath,
    Map<String, FeatureRouteData> routeDataMap,
  ) {
    for (final route in routes) {
      if (route is FeatureRoute) {
        final path = _combinePaths(parentPath, route.path);
        if (route.name != null) {
          routeDataMap[route.name!] = FeatureRouteData(
            name: route.name!,
            description: route.description,
            fullPath: path,
          );
        }
        if (route.routes.isNotEmpty) {
          _traverseRoutes(route.routes, path, routeDataMap);
        }
      }
      // else if (route is GoRoute) {
      //   final path = _combinePaths(parentPath, route.path);
      //   if (route.name != null) {
      //     routeDataMap[route.name!] = FeatureRouteData(
      //       name: route.name!,
      //       description: '', // Provide a default or handle accordingly
      //       fullPath: path,
      //     );
      //   }
      //   if (route.routes.isNotEmpty) {
      //     _traverseRoutes(route.routes, path, routeDataMap);
      //   }
      // }
      else if (route is ShellRoute) {
        // For ShellRoute, path is the same as parentPath
        if (route.routes.isNotEmpty) {
          _traverseRoutes(route.routes, parentPath, routeDataMap);
        }
      } else if (route is StatefulShellRoute) {
        // Handle StatefulShellRoute
        if (route.branches.isNotEmpty) {
          for (final branch in route.branches) {
            if (branch.routes.isNotEmpty) {
              _traverseRoutes(branch.routes, parentPath, routeDataMap);
            }
          }
        }
      }
    }
  }

  static String _combinePaths(String parentPath, String childPath) {
    if (childPath.startsWith('/')) {
      return childPath;
    } else {
      if (parentPath.endsWith('/')) {
        return '$parentPath$childPath';
      } else {
        return '$parentPath/$childPath';
      }
    }
  }
}
