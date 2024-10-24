// lib/provider/route_data_provider.dart

import 'package:feature_navigator/feature_router.dart';
import 'package:feature_navigator/model/feature_router.dart';
import 'package:go_router/go_router.dart';

class RouteDataProvider {
  static final Map<String, FeatureRouteData> _routeDataMap = {};

  static void initializeRoutes(List<RouteBase> routes) {
    _routeDataMap.clear();
    _traverseRoutes(routes, '', _routeDataMap, {});
  }

  static List<String> getAllRouteNames() => _routeDataMap.keys.toList();

  static String? getRouteDescription(String name) =>
      _routeDataMap[name]?.description;

  static String? getFullPath(String name) => _routeDataMap[name]?.fullPath;

  static void _traverseRoutes(
    List<RouteBase> routes,
    String parentPath,
    Map<String, FeatureRouteData> routeDataMap,
    Map<String, dynamic> parentParameters,
  ) {
    for (final route in routes) {
      if (route is FeatureRoute) {
        final path = _combinePaths(parentPath, route.path);

        if (route.name != null) {
          if (route.parameters.isEmpty) {
            // No parameters for this route, use parentParameters
            String adjustedFullPath = path;
            parentParameters.forEach((paramName, paramValue) {
              final id = paramValue is Map<String, dynamic> &&
                      paramValue.containsKey('id')
                  ? paramValue['id']
                  : paramValue.toString();
              adjustedFullPath = adjustedFullPath.replaceAll(':$paramName', id);
            });

            String adjustedName = route.name!;
            String adjustedDescription = route.description;

            // Adjust the name and description with parent parameters
            parentParameters.forEach((paramName, paramValue) {
              final displayName = paramValue is Map<String, dynamic> &&
                      paramValue.containsKey('name')
                  ? paramValue['name']
                  : paramValue.toString();
              adjustedName += '_$displayName';
              adjustedDescription += ' ($paramName: $displayName)';
            });

            // Add to routeDataMap
            routeDataMap[adjustedName] = FeatureRouteData(
              name: adjustedName,
              description: adjustedDescription,
              fullPath: adjustedFullPath,
            );

            // Process nested routes with the same parameters
            if (route.routes.isNotEmpty) {
              _traverseRoutes(
                  route.routes, path, routeDataMap, parentParameters);
            }
          } else {
            // Route has parameters
            final parameterNames = route.parameters.keys.toList();
            final parameterValuesList =
                route.parameters.values.toList(); // List of dynamic values

            // Generate all combinations of parameter values
            final combinations = _generateCombinations(parameterValuesList);

            for (final combination in combinations) {
              // Create a map from parameter name to value
              final parameterMap = <String, dynamic>{};
              for (int i = 0; i < parameterNames.length; i++) {
                parameterMap[parameterNames[i]] = combination[i];
              }

              // Merge with parent parameters
              final allParameters = {...parentParameters, ...parameterMap};

              // Replace the path parameters with actual IDs
              String adjustedFullPath = path;
              allParameters.forEach((paramName, paramValue) {
                final id = paramValue is Map<String, dynamic> &&
                        paramValue.containsKey('id')
                    ? paramValue['id']
                    : paramValue.toString();
                adjustedFullPath =
                    adjustedFullPath.replaceAll(':$paramName', id);
              });

              // Adjust the name and description using display names
              String adjustedName = route.name!;
              String adjustedDescription = route.description;
              allParameters.forEach((paramName, paramValue) {
                final displayName = paramValue is Map<String, dynamic> &&
                        paramValue.containsKey('name')
                    ? paramValue['name']
                    : paramValue.toString();
                adjustedName += '_$displayName';
                adjustedDescription += ' ($paramName: $displayName)';
              });

              // Add to routeDataMap
              routeDataMap[adjustedName] = FeatureRouteData(
                name: adjustedName,
                description: adjustedDescription,
                fullPath: adjustedFullPath,
              );

              // Process nested routes with updated parameters
              if (route.routes.isNotEmpty) {
                _traverseRoutes(
                    route.routes, path, routeDataMap, allParameters);
              }
            }
          }
        } else {
          // If route.name is null, just process nested routes
          if (route.routes.isNotEmpty) {
            _traverseRoutes(route.routes, path, routeDataMap, parentParameters);
          }
        }
      } else if (route is ShellRoute) {
        // For ShellRoute, path is the same as parentPath
        if (route.routes.isNotEmpty) {
          _traverseRoutes(
              route.routes, parentPath, routeDataMap, parentParameters);
        }
      } else if (route is StatefulShellRoute) {
        // Handle StatefulShellRoute
        if (route.branches.isNotEmpty) {
          for (final branch in route.branches) {
            if (branch.routes.isNotEmpty) {
              _traverseRoutes(
                  branch.routes, parentPath, routeDataMap, parentParameters);
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

  static List<List<dynamic>> _generateCombinations(
      List<dynamic> parameterValuesList) {
    List<List<dynamic>> combinations = [[]];
    for (dynamic parameterValues in parameterValuesList) {
      List<List<dynamic>> newCombinations = [];
      if (parameterValues is List) {
        // For List<String> parameters
        for (List<dynamic> combination in combinations) {
          for (dynamic value in parameterValues) {
            newCombinations.add([...combination, value]);
          }
        }
      } else if (parameterValues is Map) {
        // For Map<String, String> parameters
        for (List<dynamic> combination in combinations) {
          for (String id in parameterValues.keys) {
            final name = parameterValues[id];
            newCombinations.add([
              ...combination,
              {'id': id, 'name': name}
            ]);
          }
        }
      }
      combinations = newCombinations;
    }
    return combinations;
  }
}
