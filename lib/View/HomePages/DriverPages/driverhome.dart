import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/View/Compenents/theme.dart';
import 'package:rafik/View/HomePages/DriverPages/userslistpage.dart';

import '../../../Controller/ridescontroller.dart';
import '../../Compenents/components.dart';
import 'DriverProfilePage.dart';
import 'driverridedetails.dart';

class DriverHomePage extends StatefulWidget {
  @override
  DriverHomePageState createState() => DriverHomePageState();
}

class DriverHomePageState extends State<DriverHomePage> {
  TextEditingController departlocation = TextEditingController();
  TextEditingController destination = TextEditingController();
  // TextEditingController date = TextEditingController();
  TextEditingController seats = TextEditingController();
  TextEditingController price = TextEditingController();
  var currentIndex = 0;
  RidesController ridesController = Get.find();
  Authcontroller authcontroller = Get.find();
  String title = 'Your Upcoming Rides';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: lightgreen,
          //extendBodyBehindAppBar: true,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: lightgreen,
              elevation: 5,
              centerTitle: false,
              title: Text(
                title,
                style: Get.textTheme.headlineLarge,
                // style: Get.textTheme.titleLarge!.copyWith(color: white),
              )),
          bottomNavigationBar: Container(
            color: lightgreen,
            height: size.width * .155,
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: size.width * .024),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                    if (currentIndex == 1) {
                      // ridesController.getUsersTochat();
                    }
                    title = currentIndex == 0
                        ? 'Your Upcoming Rides'
                        : currentIndex == 1
                            ? 'Messeges'
                            : currentIndex == 2
                                ? 'Add Ride'
                                : 'Profile';
                    // print(index);
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: SizedBox(
                  width: Get.width / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: size.width * .014),
                      Icon(listOfIcons[index],
                          size: size.width * .076, color: Colors.white),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        margin: EdgeInsets.only(
                          top: index == currentIndex ? 0 : size.width * .029,
                          right: size.width * .0422,
                          left: size.width * .0422,
                        ),
                        width: size.width * .153,
                        height: index == currentIndex ? size.width * .014 : 0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Stack(children: [
            GetBuilder<RidesController>(builder: (controller) {
              return controller.isloading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container();
            }),
            bodycontenent(),
            GetBuilder<RidesController>(builder: (controller) {
              return controller.isloading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container();
            }),
          ])),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Iconsax.message,
    Iconsax.add,
    Icons.person_rounded,
  ];

  Center ridedetails(int index) {
    return Center(
      child: OpenContainer(
        closedBuilder: (_, openContainer) {
          return Container(
            height: Get.height * 0.2,
            width: Get.width * 0.95,
            child: Row(
              children: [
                SizedBox(
                    width: Get.width * 0.4,
                    height: Get.height * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        ridesController.searchedrides[index].driver!.image,
                        fit: BoxFit.cover,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${ridesController.searchedrides[index].from} - ${ridesController.searchedrides[index].to}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Date : ${ridesController.searchedrides[index].date}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Price : ${ridesController.searchedrides[index].price}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Seats availble : ${ridesController.searchedrides[index].seats}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Rating : ${ridesController.searchedrides[index].driver!.rating}',
                        style: Get.textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        openColor: Colors.white,
        closedElevation: 5.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        closedColor: Colors.white,
        openBuilder: (_, closeContainer) {
          return DriverRideDetails(
            ride: ridesController.searchedrides[index],
            closeContainer: closeContainer,
          );
        },
      ),
    );
  }

  Widget addridepage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: Get.width * 0.4,
              width: Get.width * 0.4,
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            mytextField(controller: departlocation, label: 'Depart Location'),
            const SizedBox(
              height: 30,
            ),
            mytextField(controller: destination, label: 'Destination Location'),
            const SizedBox(
              height: 30,
            ),
            mytextField(controller: price, label: 'Price'),
            const SizedBox(
              height: 30,
            ),
            mytextField(controller: seats, label: 'Number Of Seats Available'),
            const SizedBox(
              height: 30,
            ),
            //  mytextField(controller: date, label: 'Date'),

            mybutton(
                ontap: () {
                  print('Creat New ride tapped');

                  DateTime now = DateTime.now();

                  DateFormat yearFormat = DateFormat('yyyy');
                  DateFormat monthFormat = DateFormat('MM');
                  DateFormat dayFormat = DateFormat('dd');
                  DateFormat hourFormat = DateFormat('HH');
                  DateFormat minuteFormat = DateFormat('mm');

                  String year = yearFormat.format(now);
                  String month = monthFormat.format(now);
                  String day = dayFormat.format(now);
                  String hour = hourFormat.format(now);
                  String minute = minuteFormat.format(now);

                  print('$year-$month-$day $hour:$minute');
                  ridesController.addnewRide(
                      from: departlocation.text,
                      to: destination.text,
                      price: price.text,
                      date: '$year-$month-$day $hour:$minute',
                      seats: seats.text,
                      driver: authcontroller.driverProfile!);
                },
                cntr: Text('Creat New Ride'))
          ],
        ),
      ),
    );
  }

  Widget bodycontenent() {
    return currentIndex == 0
        ? GetBuilder<RidesController>(builder: (ridecontrller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ridedetails(index);
                },
                itemCount: ridecontrller.searchedrides.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              ),
            );
          })
        : currentIndex == 1
            ? MessegePage()
            : currentIndex == 2
                ? addridepage()
                : DriverProfileScreen();
  }
}
