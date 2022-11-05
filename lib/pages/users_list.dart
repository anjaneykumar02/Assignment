import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:userinfo/pages/user_info.dart';
import '../utils/app.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  UsersListState createState() => UsersListState();
}

class UsersListState extends State<UsersList> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection('users')
                  .orderBy('name', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (con, item) {
                      return GestureDetector(
                        onTap: () {
                          String name =
                              snapshot.data!.docs.elementAt(item)["name"]!;
                          String phone =
                              snapshot.data!.docs.elementAt(item)["phone"]!;
                          String age =
                              snapshot.data!.docs.elementAt(item)["age"]!;
                          String department = snapshot.data!.docs
                              .elementAt(item)["department"]!;
                          String image =
                              snapshot.data!.docs.elementAt(item)["image"]!;

                          Route route = MaterialPageRoute(
                              builder: (context) => UserInfo(
                                    name: name,
                                    age: age,
                                    department: department,
                                    image: image,
                                    phone: phone,
                                  ));
                          Navigator.push(context, route);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: boxDecorationRoundedWithShadow(8,
                              blurRadius: 5, backgroundColor: Colors.white),
                          child: Row(
                            children: [
                              networkImage(
                                      snapshot.data!.docs
                                          .elementAt(item)["image"]!,
                                      fit: BoxFit.fill,
                                      aWidth: 60,
                                      aHeight: 60)
                                  .cornerRadiusWithClipRRect(50),
                              10.width,
                              Text(snapshot.data!.docs.elementAt(item)["name"],
                                  style: boldTextStyle()),
                              Expanded(
                                child: Container(),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  DocumentSnapshot ds =
                                      snapshot.data!.docs[item];
                                  db.collection('users').doc(ds.id).delete();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(height: 60, child: bottomBar(context)),
    );
  }
}
