import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopularIceCream extends StatelessWidget {
  const PopularIceCream({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    CollectionReference data = FirebaseFirestore.instance.collection('data');

    return Container(
      width: width,
      height: height * 10 / 100,
      child: FutureBuilder<DocumentSnapshot>(
        future: data.doc("popularIceCream").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data.data() as Map<String, dynamic>;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data["iceCream"].length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(17)),
                    width: width * 40 / 100,
                    height: height * 5 / 100,
                    child: Row(
                      children: [
                        Container(
                          width: width * 13 / 100,
                          height: height * 10 / 100,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(17)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width * 2 / 100),
                          child: Text(data["iceCream"][index]),
                        ),
                      ],
                    ),
                  );
                });
          }

          return Text("loading");
        },
      ),
    );
  }
}
