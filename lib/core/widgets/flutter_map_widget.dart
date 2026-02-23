import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/theme.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapWidget extends StatelessWidget {
  const FlutterMapWidget({
    super.key,
    required this.latLng,
    this.mapController,
    this.userLatLng,
    this.markers = const [],
  });

  final LatLng latLng;
  final MapController? mapController;
  final LatLng? userLatLng;
  final List<LatLng> markers;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(initialCenter: latLng, initialZoom: 17),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          userAgentPackageName: 'com.sweet.shop.flutter_sweet_shop_app_ui',
        ),
        MarkerLayer(
          markers: [
            for (final marker in markers)
              Marker(
                point: marker,
                width: 36,
                height: 36,
                child: Icon(
                  Icons.location_pin,
                  color: context.theme.appColors.primary,
                  size: 36,
                ),
              ),
            if (userLatLng != null)
              Marker(
                point: userLatLng!,
                width: 40,
                height: 40,
                child: Icon(
                  Icons.person_pin_circle,
                  color: context.theme.appColors.secondary,
                  size: 40,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
