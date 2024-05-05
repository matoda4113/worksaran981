

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

///로거 (디버그용 로거)
Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 1,
    lineLength: 130,
    colors: true,
    printEmojis: false,
    printTime: false,
  ),
);

///yyyy-mm-dd 형태를 받아 무슨요일인지 한국어로 나타냄
String getKoreanWeekday(String dateStr) {
  // 날짜 문자열에서 DateTime 객체 생성
  List<int> parts = dateStr.split('-').map(int.parse).toList();
  DateTime date = DateTime(parts[0], parts[1], parts[2]);

  // 요일을 한국어로 변환
  List<String> weekdays = ['일', '월', '화', '수', '목', '금', '토'];
  String koreanWeekday = weekdays[date.weekday % 7]; // DateTime.weekday는 1(월요일)부터 7(일요일)까지의 값을 반환

  return koreanWeekday;
}

/// 숫자를 받아서 000 마다 ,콤마를 붙여줌
String formatNumber(int number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}


///status 에 따라 색상을 다르게줌
Color getTextColor(int status){
  if(status == -1){
    return Colors.grey;
  }else if(status == 0){
    return Colors.blue;
  }else if(status == 1) {
    return Colors.green;
  }else if(status == 2) {
    return Colors.red;
  }else{
    return Colors.grey;
  }
}