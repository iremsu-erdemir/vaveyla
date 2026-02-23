import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationState());

  Future<void> requestLocation() async {
    emit(state.copyWith(status: LocationStatus.loading, message: null));

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(
        state.copyWith(
          status: LocationStatus.error,
          message: 'Konum servisleri kapalı. Lütfen açıp tekrar deneyin.',
        ),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      emit(
        state.copyWith(
          status: LocationStatus.denied,
          message: 'Konumunuzu gösterebilmemiz için izin vermeniz gerekiyor.',
        ),
      );
      return;
    }

    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (_) {
      position = await Geolocator.getLastKnownPosition();
    }

    if (position == null) {
      emit(
        state.copyWith(
          status: LocationStatus.error,
          message: 'Konum alınamadı. Lütfen tekrar deneyin.',
        ),
      );
      return;
    }

    String? city;
    String? country;
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final place = placemarks.isNotEmpty ? placemarks.first : null;
      city = place?.administrativeArea ?? place?.locality;
      country = place?.country;
    } catch (_) {
      city = null;
      country = null;
    }

    emit(
      state.copyWith(
        status: LocationStatus.success,
        latitude: position.latitude,
        longitude: position.longitude,
        city: city,
        country: country,
      ),
    );
  }
}
