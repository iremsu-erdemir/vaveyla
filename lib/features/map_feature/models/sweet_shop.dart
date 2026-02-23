import 'package:latlong2/latlong.dart';

class SweetShop {
  const SweetShop({
    required this.name,
    required this.address,
    required this.location,
    required this.description,
    required this.deliveryInfo,
  });

  final String name;
  final String address;
  final LatLng location;
  final String description;
  final String deliveryInfo;
}
