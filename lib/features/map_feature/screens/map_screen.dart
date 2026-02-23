import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/flutter_map_widget.dart';
import '../../../core/widgets/general_app_bar.dart';
import '../models/sweet_shop.dart';
import '../widgets/stores_on_map_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const stores = [
      SweetShop(
        name: 'Edirne Sultanzade',
        address: 'Muaffıklarhane Sk., Sabuni Mh., Edirne',
        location: LatLng(41.6757164, 26.5547864),
        description: 'badem ezmesi, lokum, şekerleme',
        deliveryInfo: '12 dk, 1.1 km, Ücretsiz Teslimat',
      ),
      SweetShop(
        name: 'Çeçe Baklava',
        address: 'Balık Pazarı Cd., Dilaverbey Mh., Edirne',
        location: LatLng(41.6740066, 26.5528021),
        description: 'baklava, şerbetli tatlılar',
        deliveryInfo: '15 dk, 1.4 km, Ücretsiz Teslimat',
      ),
      SweetShop(
        name: 'Efendioğulları Baklava Lokum',
        address: 'Atatürk Blv., Abdurrahman Mh., Edirne',
        location: LatLng(41.6681158, 26.5702769),
        description: 'baklava, lokum, fıstıklı tatlılar',
        deliveryInfo: '18 dk, 2.3 km, Ücretsiz Teslimat',
      ),
      SweetShop(
        name: 'Sayınbaş Şekerleme',
        address: 'Balık Pazarı Cd., Dilaverbey Mh., Edirne',
        location: LatLng(41.6741273, 26.5529304),
        description: 'şekerleme, lokum, draje',
        deliveryInfo: '14 dk, 1.3 km, Ücretsiz Teslimat',
      ),
    ];

    return AppScaffold(
      appBar: GeneralAppBar(title: 'Harita', showBackIcon: false),
      padding: EdgeInsets.zero,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FlutterMapWidget(
            latLng: stores.first.location,
            markers: stores.map((store) => store.location).toList(),
          ),
          StoresOnMapScreen(stores: stores),
        ],
      ),
    );
  }
}
