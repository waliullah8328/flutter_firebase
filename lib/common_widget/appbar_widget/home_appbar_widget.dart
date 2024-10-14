import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../screens/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller;

  HomeScreen({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBarWidget(context: context, controller: controller),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text("Drawer Header")),
            const ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text("Setting"),
            ),
            const ListTile(
              leading: Icon(Icons.help),
              title: Text("Help"),
            ),
            const SizedBox(height: 320),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Exit App?"),
                          content: const Text(
                              "Are you sure you want to exit the app?"),
                          actions: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.cancel),
                              label: const Text("Cancel"),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              icon: const Icon(Icons.exit_to_app),
                              label: const Text("Exit"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text("Exit"),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(child: Text('Home Page Content')),
    );
  }
}

class HomeAppBarWidget extends AppBar {
  final BuildContext context;
  final HomeController controller;

  HomeAppBarWidget({
    super.key,
    required this.context,
    required this.controller,
  }) : super(
    backgroundColor: Colors.white,
    title: Text(
      "E-Commerz",
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevation: 2,
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    ),
    actions: [
      IconButton(
        onPressed: controller.goToCartScreen,
        icon: Icon(
          Icons.shopping_cart_outlined,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ],
  );
}
