import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:worksaran981/vo/date_vo.dart';
import '../vo/product_schedule_vo.dart';
import 'helper.dart';

class HttpServiceSaran {

  Future<List<DateVo>> getDate() async{
    //json파일을 불러오기
    String jsonString = await rootBundle.loadString('assets/jsonFiles/date.json');
    //불러온파일 디코딩하기
    Map<String,dynamic> mapData = json.decode(jsonString);
    if (mapData['code'] == "EC200") {
      List<DateVo> result = [];
      mapData['data'].forEach((v){
        DateVo t = DateVo.fromJson(v);
        result.add(t);
      });
      return result;
    } else {
      throw Exception('error');
    }
  }

  Future<ProductScheduleVo> getTimeList(String date , String productCode) async{

    //json파일을 불러오기
    String day = getKoreanWeekday(date);
    String jsonString = "";
    if(day=="일"){
      jsonString = await rootBundle.loadString('assets/jsonFiles/sunday.json');
    }else{
      jsonString = await rootBundle.loadString('assets/jsonFiles/basic.json');
    }
    //불러온파일 디코딩하기
    Map<String,dynamic> mapData = json.decode(jsonString);
    if (mapData['code'] == "EC200") {
      ProductScheduleVo result=ProductScheduleVo.fromJson(mapData['data']);

      //4월 4,2일에 대한 정보밖에 없으므로 나머지 날짜는 타임슬롯 정보가 없는걸로 가정한다
      if(date == "2021-04-04" || date == "2021-04-02"){
        return result;
      }else{
        result.timeList=[];
        result.reserveDt = date;
        return result;
      }

    } else {
      throw Exception('error');
    }

  }

}