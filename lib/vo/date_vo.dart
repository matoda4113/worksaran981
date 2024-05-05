import '../service/helper.dart';

class DateVo {
  int? dplId;
  String? date;
  bool? enabled;
  bool? holidayYn;
  int? year;
  int? month;
  int? day;
  String? dayOfKorean;

  DateVo({
    this.dplId,
    this.date,
    this.enabled,
    this.holidayYn,
    this.year,
    this.month,
    this.day,
    this.dayOfKorean,
  });

  DateVo.fromJson(Map<String, dynamic> json) {
    dplId = json['dplId'];
    date = json['date'];
    enabled = json['enabled'];
    holidayYn = json['holidayYn'];
    year = int.parse(json['date'].substring(0, 4));
    month = int.parse(json['date'].substring(5, 7));
    day = int.parse(json['date'].substring(8, 10));

    dayOfKorean = getKoreanWeekday(json['date']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dplId'] = this.dplId;
    data['date'] = this.date;
    data['enabled'] = this.enabled;
    data['holidayYn'] = this.holidayYn;
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
    data['dayOfKorean'] = this.dayOfKorean;
    return data;
  }
}