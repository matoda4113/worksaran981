import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:worksaran981/controller/schedule_controller.dart';
import 'package:worksaran981/pages/schedule_page.dart';

import '../main.dart';
import '../service/helper.dart';

///MainPage
///담당자 : saran

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
    logger.i("MainPage");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleController>(
      builder: (context,scheduleController,child) {
        return Scaffold(
          appBar: AppBar(title: Text("티켓팅 메인페이지"),),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 2/1,
                  child: GestureDetector(
                    onTap: () async{
                      try{
                        //먼저 눌렀을때 데이터 로딩후 완료되면 페이지로 넘어감
                        await scheduleController.getProductSchedule();
                        Get.to(SchedulePage(productName: "1-2-3 코스 자유"));
                      }catch(error){
                        logger.e(error);
                      }
                    },
                    child: Container(
                      width: Get.width,

                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/img-race-9811.png'),
                          ),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DecoratedText(
                            'RACE 3회(1,2,3코스 자유)',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fillColor: Colors.white,
                            borderWidth: 1,
                          ),
                          DecoratedText(
                            '1인승 레이싱 3회권',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fillColor: Colors.white,
                            borderWidth: 1,
                          ),
                          DecoratedText(
                            '5인 패키지',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fillColor: Colors.white,
                            borderWidth: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        );
      }
    );
  }
}



