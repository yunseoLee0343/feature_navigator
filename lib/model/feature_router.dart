// lib/model/feature_route_data.dart

class FeatureRouteData {
  final String name;
  final String description;
  final String fullPath;
  final Map<String, dynamic> extra;

  FeatureRouteData({
    required this.name,
    required this.description,
    required this.fullPath,
    this.extra = const {},
  });
}
