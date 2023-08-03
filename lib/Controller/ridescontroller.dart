import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rafik/Model/driver.dart';
import 'package:rafik/Model/ride.dart';

import '../Model/user.dart';
import '../View/HomePages/UserPages/chatpage.dart';

class RidesController extends GetxController {
  bool isloading = false;
  var hendPayment = true;
  List<Ride> searchedrides = [
    Ride(
      from: 'Algeria',
      to: "Setif",
      price: '1000',
      date: DateTime.now().month.toString(),
      seats: 4,
      driver: Driver(
          uid: 'fHmX5f4GgaelG9bRR87viOotkak1',
          carmodele: 'picanto 2012',
          email: 'azzouz@gmail.com',
          name: 'azzouz',
          rating: '1',
          image:
              'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil-cheveux-verts_23-2149436201.jpg?w=740&t=st=1690473822~exp=1690474422~hmac=fa024e8d7501f866eb9c6a5049f82d755c79701b6ccaa8e4cb458d3034b73ce3'),
    ),
    Ride(
      from: 'Ourgla',
      to: "Mila",
      price: '700',
      date: DateTime.now().month.toString(),
      seats: 4,
      driver: Driver(
          email: 'azzouzmerouani@gmail.com',
          uid: '45881632jusckmcl',
          carmodele: 'Symbole',
          name: 'Akedkad',
          rating: '5.0',
          image:
              "https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436188.jpg?w=740&t=st=1690473670~exp=1690474270~hmac=48da6f35f154f9d57e3e27d4cf96c1c53d653393278091564791de9faaa9a33d"),
    ),
    Ride(
      from: 'Algeria',
      to: "Setif",
      price: '1000',
      date: DateTime.now().month.toString(),
      seats: 4,
      driver: Driver(
          email: 'azzouzmerouani@gmail.com',
          uid: '45881632jusckmcl',
          carmodele: 'picanto',
          name: 'Ahmed amrani',
          rating: '3.5',
          image:
              'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436180.jpg?w=740&t=st=1690473860~exp=1690474460~hmac=09877664ae7a857fed98477c4b733e68feeaabb05a6ef9507a39f2d65116b237'),
    ),
  ].obs;

  RxString searchedName = ''.obs;

  void changepaymentMethod() {
    hendPayment = !hendPayment;
    update();
  }

  void addnewRide({
    required String from,
    required String to,
    required String price,
    required String date,
    required String seats,
    required Driver driver,
  }) async {
    isloading = true;
    print(isloading);
    update();
    print("Adding new ride on firebase");
    try {
      var documentRef = await FirebaseFirestore.instance
          .collection('rides')
          .add(Ride(
                  from: from,
                  to: to,
                  price: price,
                  date: date,
                  seats: int.parse(seats),
                  driver: driver)
              .toMap());
      print("DOC ID  = $documentRef.id");
      await FirebaseFirestore.instance
          .collection('rides')
          .doc(documentRef.id)
          .update({
        'uid': documentRef.id,
      });
    } catch (e) {
      print(e);
    }
    isloading = false;
    print(isloading);
    update();
  }

  void getrides() async {
    isloading = true;
    print(isloading);
    searchedrides.clear();
    update();

    var documents = await FirebaseFirestore.instance.collection("rides").get();
    print(documents.docs.isEmpty);
    for (var element in documents.docs) {
      searchedrides.add(Ride.fromMap(element.data()));
      print(element.data());
    }
    print(searchedrides);
    isloading = false;
    update();
  }

  List appusers = [];

  void bookRide(Ride ride, int seats) {
    FirebaseFirestore.instance.collection('rides').doc(ride.uid).update({
      "seats": seats - 1,
    }).then((value) {
      print('Secccses');

      Get.to(
        ChatPage(ride!.driver!),
      );
    }).catchError((e) {
      print(e);
    });
  }

  void getUsersTochat() {
    isloading = true;
    update();

    FirebaseFirestore.instance.collection('users').get().then((value) async {
      value.docs.forEach((element) {
        appusers.add(AppUser.fromMap(element.data()));
      });

      print('The Users ${appusers}');
      isloading = false;
      update();
    }).onError((error, stackTrace) {
      print(error.toString());
      Get.showSnackbar(GetSnackBar(
          message: error.toString(),
          icon: const Icon(
            Iconsax.warning_2,
          )));
      isloading = false;
      update();
    });
  }

  List drivers = [];

  void getDriversTochat() {
    isloading = true;
    update();

    FirebaseFirestore.instance.collection('drivers').get().then((value) async {
      value.docs.forEach((element) {
        drivers.add(Driver.fromMap(element.data()));
      });

      print('The Users ${appusers}');
      isloading = false;
      update();
    }).onError((error, stackTrace) {
      print(error.toString());
      Get.showSnackbar(GetSnackBar(
          message: error.toString(),
          icon: const Icon(
            Iconsax.warning_2,
          )));
      isloading = false;
      update();
    });
  }

  void searchrides(String searchName) {
    searchedName.value = searchName;
    print(searchedName);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    appusers.clear();
    getUsersTochat();
    getDriversTochat();
    getrides();
  }
}
