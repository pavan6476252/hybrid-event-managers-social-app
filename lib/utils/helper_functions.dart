// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HelperFunctions {
  static String countToKsConvertion(int count) {
    if (count > 999) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    } else {
      return count.toString();
    }
  }

  //get

  static Future<LocationInfo> getLocationInfo() async {
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude, currentPosition.longitude);

    // Placemark place = placemarks[0];

    // _currentCity = place.locality;
    return LocationInfo(
        placemarks: placemarks,
        geoPoint:
            GeoPoint(currentPosition.latitude, currentPosition.longitude));
  }
}

class LocationInfo {
  final List<Placemark> placemarks;
  final GeoPoint geoPoint;
  LocationInfo({
    required this.placemarks,
    required this.geoPoint,
  });
}
