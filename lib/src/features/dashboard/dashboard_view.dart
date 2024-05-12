import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_with_db/src/features/dashboard/dashboard_controller.dart';
import 'package:testing_with_db/src/features/dashboard/post_tile.dart';

class DashboardView extends StatelessWidget {
  final DashboardController dashboardController = Get.find();

  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dashboardController.fetchPosts();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reddit Clone'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.toNamed("/create");
                  },
                  child: const Text("Create"),
                ),
                Expanded(
                  child: Obx(() => ListView.builder(
                        itemCount: dashboardController.posts.length,
                        itemBuilder: (context, index) {
                          return PostTile(
                              post: dashboardController.posts[index]);
                        },
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
