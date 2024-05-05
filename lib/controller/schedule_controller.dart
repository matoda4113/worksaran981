import 'package:flutter/material.dart';

import '../service/http_service.dart';
import '../vo/date_group_vo.dart';
import '../vo/date_vo.dart';
import '../vo/product_schedule_vo.dart';

class ScheduleController with ChangeNotifier {
  final HttpServiceSaran httpService = HttpServiceSaran();
  List<DateGroupVo> availableDateGroup = []; //현재 선택된 상품의 이용가능한 날짜 리스트(그룹별로 묶인것)
  DateGroupVo? selectedMonth; //한개 월에 대한 타임슬롯및 기타정보

  /// 상품 이용가능한 날짜 조회
  Future<void> getProductSchedule() async{

    availableDateGroup = []; // 날짜리스트 초기화
    selectedMonth = null; //선택월 초기화
    try{
      List<DateVo> availableDate = await httpService.getDate();

      // 날짜 데이터를 연도와 월로 그룹화
      Map<String, DateGroupVo> groupedMap = {};
      for (DateVo dateVo in availableDate) {
        String key = dateVo.date!.substring(0, 7);
        if (!groupedMap.containsKey(key)) {
          groupedMap[key] = DateGroupVo(
              year: int.parse(key.substring(0, 4)),
              month: int.parse(key.substring(5, 7)),
              dateList: []
          );
        }
        if(dateVo.enabled!){
          groupedMap[key]?.dateList?.add(dateVo);
        }
      }
      // Map을 List로 변환
      availableDateGroup = groupedMap.values.toList();
      selectedMonth = availableDateGroup[0];

    }catch(error){
      throw Exception('Error : $error');
    }finally{
      notifyListeners();
    }
  }

  ///선택된 월 변경
  void changeSelectedMonth(int index){
    selectedMonth = availableDateGroup[index];
    notifyListeners();
  }

  ///선택된 월에 대한 해당상품의 스케쥴 정보 조회
  Future<ProductScheduleVo> getTimeList(String date , String productCode) async{
    try{
      ProductScheduleVo productScheduleVo = await httpService.getTimeList(date, productCode);
      return productScheduleVo;
    }catch(error){
      throw Exception('Error : $error');
    }
  }


}