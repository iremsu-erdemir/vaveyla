part of 'location_cubit.dart';

enum LocationStatus { idle, loading, success, denied, error }

class LocationState {
  const LocationState({
    this.status = LocationStatus.idle,
    this.latitude,
    this.longitude,
    this.city,
    this.country,
    this.message,
  });

  final LocationStatus status;
  final double? latitude;
  final double? longitude;
  final String? city;
  final String? country;
  final String? message;

  LocationState copyWith({
    LocationStatus? status,
    double? latitude,
    double? longitude,
    String? city,
    String? country,
    String? message,
  }) {
    return LocationState(
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
      country: country ?? this.country,
      message: message ?? this.message,
    );
  }
}
