import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_with_db/firebase_options.dart';
import 'package:testing_with_db/src/features/dashboard/dashboard_controller.dart';
import 'package:testing_with_db/src/features/dashboard/dashboard_view.dart';
import 'package:testing_with_db/src/features/posts/create_post_controller.dart';
import 'package:testing_with_db/src/features/posts/create_post_view.dart';
import 'package:testing_with_db/src/features/posts/see_post_controller.dart';
import 'package:testing_with_db/src/features/posts/see_post_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Similar to our old code: Screens for every module One-time instantiation of controllers (Tama ba ko?)
  Get.lazyPut<DashboardController>(
    () => DashboardController(),
    fenix: true,
  );

  Get.lazyPut<CreatePostController>(
    () => CreatePostController(),
    fenix: true,
  );

  Get.lazyPut<SeePostController>(
    () => SeePostController(),
    fenix: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        // Similar to our old code: Screens for every module
        getPages: [
          GetPage(
            name: '/',
            page: () => DashboardView(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/create',
            page: () => CreatePostView(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/see/:uid',
            page: () => SeePostView(),
            transition: Transition.noTransition,
          ),
        ]);
  }
}
