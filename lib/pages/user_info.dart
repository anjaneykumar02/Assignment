import 'package:flutter/material.dart';

import '../utils/app.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/app_colors.dart';

class UserInfo extends StatefulWidget {
  const UserInfo(
      {Key? key,
      required this.name,
      required this.phone,
      required this.age,
      required this.department,
      required this.image})
      : super(key: key);
  final String name;
  final String phone;
  final String age;
  final String department;
  final String image;

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('UserInfo'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                80.height,
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border:
                        Border.all(color: AppColors.appColorPrimary, width: 1),
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: Image(
                    image: NetworkImage(widget.image, scale: 1),
                  ).cornerRadiusWithClipRRect(90),
                ),
                20.height,
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                25.height,
                Text(
                  "Age: ${widget.age}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                6.height,
                Text(
                  "Mobile: ${widget.phone}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                6.height,
                Text(
                  "Department: ${widget.department}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: bottomBar(context),
        ),
      ),
    );
  }
}
