import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class LocationsController extends GetxController {
  TextEditingController pickupEditingController = TextEditingController();
  TextEditingController destinationEditingController = TextEditingController();
  RxInt selectedlocation = 1000.obs;
  List<String> locations = [
    'Setif vill,Setif',
    'Ouad bibi,Skikda',
    'El eulma,Setif',
    'ain arnet,Setif',
  ];

  void changePickup(String locName) {
    pickupEditingController.text = locName;
    print(destinationEditingController.text);
  }

  void changeselctedlocation(index) {
    selectedlocation.value = index;
    destinationEditingController.text = locations[index];
    print(destinationEditingController.text);
  }

  void locationpermissions() async {
    var status = await Permission.locationWhenInUse.status;
    print("Status is $status");
    if (status != PermissionStatus.granted) {
      status = await Permission.locationWhenInUse.request().then((value) {
        print("Status is $value");

        return value;
      });
    } else {
      print('Permission garented');
    }
  }

  Future<String> getLocationName(double lat, double lng) async {
    final url =
        "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lng&format=json";
    final response = await http.get(Uri.parse(url));
    var myDataString = utf8.decode(response.bodyBytes);
    final data = jsonDecode(myDataString);
    print(data);
    final String locName = data['display_name'];

    // var decoded = utf8.decode(utf8.fuse(locName));

    //print(decoded);
    Get.snackbar('Your Location', locName);
    print(locName);
    return locName ?? 'null';
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    locationpermissions();
  }
}
