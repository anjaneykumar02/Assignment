import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:userinfo/controller/fire_controller.dart';
import '../utils/app.dart';
import '../utils/app_colors.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  UserFormState createState() => UserFormState();
}

class UserFormState extends State<UserForm> {
  var formKey = GlobalKey<FormState>();

  var isLoading = false;

  var nameCont = TextEditingController();
  var phoneCont = TextEditingController();
  var ageCont = TextEditingController();

  final controller = Get.find<FireController>();

  var nameNode = FocusNode();
  var salaryNode = FocusNode();
  var ageNode = FocusNode();

  List<String> department = <String>[
    "HR",
    "Finance",
    "Housekeeping",
    "Marketing"
  ];
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = department.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USER FORM'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: GetBuilder<FireController>(builder: (_) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    16.height,
                    TextFormField(
                      controller: nameCont,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                        labelText: 'Enter Name',
                        border: const OutlineInputBorder(),
                        labelStyle: primaryTextStyle(),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(color: AppColors.boarderColor)),
                      ),
                      focusNode: nameNode,
                      validator: (s) {
                        if (s!.isEmpty) return 'Field is required';
                        return null;
                      },
                      onFieldSubmitted: (s) =>
                          FocusScope.of(context).requestFocus(salaryNode),
                      textInputAction: TextInputAction.next,
                    ),
                    16.height,
                    TextFormField(
                      controller: phoneCont,
                      keyboardType: TextInputType.number,
                      style: primaryTextStyle(),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        labelText: 'Enter Phone',
                        border: const OutlineInputBorder(),
                        labelStyle: primaryTextStyle(),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(color: AppColors.boarderColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(color: AppColors.boarderColor)),
                      ),
                      focusNode: salaryNode,
                      validator: (s) {
                        if (s!.isEmpty) return 'Field is required';
                        if (!s.isDigit()) return 'Please enter valid data';
                        return null;
                      },
                      onFieldSubmitted: (s) =>
                          FocusScope.of(context).requestFocus(ageNode),
                      textInputAction: TextInputAction.next,
                    ),
                    16.height,
                    TextFormField(
                      controller: ageCont,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: primaryTextStyle(),
                      decoration: InputDecoration(
                        labelText: 'Enter Age',
                        border: const OutlineInputBorder(),
                        labelStyle: primaryTextStyle(),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(color: AppColors.boarderColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(color: AppColors.boarderColor)),
                      ),
                      focusNode: ageNode,
                      validator: (s) {
                        if (s!.isEmpty) return 'Field is required';
                        if (!s.isDigit()) return 'Please enter valid data';
                        return null;
                      },
                    ),
                    16.height,
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: AppColors.boarderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward_rounded),
                          style: TextStyle(color: AppColors.boarderColor),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: department
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    16.height,
                    Container(
                      margin: const EdgeInsets.all(5),
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        // border: Border.all(
                        //     color: AppColors.appColorPrimary, width: 1),
                        // borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: IconButton(
                          onPressed: () async {
                            // await FireApi.uploadImage2(storage);
                            controller.selectImage();
                            // toasty(context, controller.uname);
                          },
                          icon: controller.isSelected
                              ? Image.file(controller.ufile)
                                  .cornerRadiusWithClipRRect(50)
                              : const Image(
                                      image: AssetImage(
                                          "assets/images/image-add.png"))
                                  .cornerRadiusWithClipRRect(50),
                        ),
                      ),
                    ),
                    10.height,
                    GestureDetector(
                      onTap: () async {
                        if (validation()) {
                          if (controller.uname.isEmpty) {
                            toasty(context, "please select image");
                          } else {
                            await controller.saveData(nameCont.text,
                                phoneCont.text, ageCont.text, dropdownValue);

                            setState(() {
                              controller.isSelected = false;
                              controller.uname = "";
                              nameCont.text = "";
                              ageCont.text = "";
                              phoneCont.text = "";
                              dropdownValue = "";
                            });
                          }
                        } else {
                          toasty(context, "please fill all fields");
                        }
                      },
                      child: !controller.isUploading
                          ? Container(
                              margin: const EdgeInsets.all(16),
                              width: MediaQuery.of(context).size.width,
                              decoration: boxDecoration(
                                  bgColor: AppColors.appColorPrimary,
                                  radius: 16),
                              padding: const EdgeInsets.all(16),
                              child: Center(
                                child: Text("SAVE",
                                    style: primaryTextStyle(color: white)),
                              ),
                            )
                          : const CircularProgressIndicator()
                              .center()
                              .visible(true),
                    ),
                  ],
                ),
              );
            }),
          ),
          const CircularProgressIndicator().center().visible(isLoading),
        ],
      ),
      bottomNavigationBar: SizedBox(height: 100, child: bottomBar(context)),
    );
  }

  bool validation() {
    // ignore: curly_braces_in_flow_control_structures
    if (nameCont.text.isNotEmpty) {
      if (nameCont.text.isNotEmpty) {
        if (nameCont.text.isNotEmpty) {
          if (nameCont.text.isNotEmpty) {
            return true;
          }
          return false;
        }
        return false;
      }
      return false;
    }
    return false;
  }
}
