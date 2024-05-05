import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:worksaran981/controller/schedule_controller.dart';
import 'package:worksaran981/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //컨트롤러 등록 (provider)
        ChangeNotifierProvider(create:(context)=>ScheduleController()),
      ],
      child: GetMaterialApp(
        home: const MainPage(),
      ),
    );
  }
}

