import 'package:flutter/material.dart';
import 'package:userinfo/pages/users_list.dart';

import '../pages/user_form.dart';
import 'app_colors.dart';

Widget networkImage(String? image,
    {String aPlaceholder = "assets/images/placeholder.png",
    double? aWidth,
    double? aHeight,
    var fit = BoxFit.fill}) {
  return image != null && image.isNotEmpty
      ? FadeInImage(
          placeholder: AssetImage(aPlaceholder),
          image: NetworkImage(image),
          width: aWidth,
          height: aHeight,
          fit: fit,
        )
      : Image.asset(
          aPlaceholder,
          width: aWidth,
          height: aHeight,
          fit: BoxFit.fill,
        );
}

boxDecoration({required Color bgColor, required double radius}) {
  return BoxDecoration(
      color: bgColor, borderRadius: BorderRadius.circular(radius));
}

Widget bottomBar(context) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            minWidth: 150,
            color: AppColors.appColorPrimary,
            child: const Text(
              "USER FORM",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (context) => const UserForm());
              Navigator.push(context, route);
            },
          ),
          MaterialButton(
            minWidth: 150,
            color: AppColors.appColorPrimary,
            child:
                const Text("USER LIST", style: TextStyle(color: Colors.white)),
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (context) => const UsersList());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
    ),
  );
}
