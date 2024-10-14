import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../backend/services/firebase_service.dart';
import '../../common_widget/text_labels/title_heading2_widget.dart';
import '../../common_widget/text_labels/title_heading3_widget.dart';
import '../../common_widget/text_labels/title_heading4_widget.dart';
import '../../utils/assets_path.dart';
import 'order_history_controller.dart';

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({super.key});

  final controller = Get.put(OrderHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseServices.myOrdersStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the data is loading, display a loading indicator
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // If there's an error, display an error message
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              // If the data is available, use it
              final List<DocumentSnapshot<Map<String, dynamic>>> documents =
                  snapshot.data!.docs;

              // List mosques = documents
              //     .map((doc) {
              //   final data = doc.data() as Map<String, dynamic>;
              //   return MosqueInfoModel.fromJson(data);
              // })
              //     .cast<MosqueInfoModel>()
              //     .toList();
              //
              // mosques.length.toString().yellowConsole;

              if (documents.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) => ordersTile(documents[index]),
                  itemCount: documents.length,
                );
              } else {
                return const Text("No Orders Here");
              }
            }));
  }

  ordersTile(data) {
    return ExpansionTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              Assets.productPlaceHolder,
              height: 50,
              width: 50,
              fit: BoxFit.fill,
            )),
        title: TitleHeading2Widget(text: data["orderId"]),
        subtitle: TitleHeading3Widget(text: "Total Price: ${data["total"]}"),
        trailing: TitleHeading4Widget(text: data["status"]),
        children: List.generate(
            data["others"].length,
            (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                        child: Image.network(
                      data["others"][index]["image"],
                      height: 40,
                      width: 40,
                    )),
                    Text(data["others"][index]["name"]),
                    Text(data["others"][index]["price"].toString())
                  ],
                )));
  }
}
