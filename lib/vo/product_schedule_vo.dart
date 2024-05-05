import 'package:worksaran981/vo/time_item_vo.dart';

class ProductScheduleVo {
  int? prdId;
  int? dplId;
  String? productName;
  String? productDisplayName;
  String? reserveDt;
  int? riderCount;
  List<TimeItemVo>? timeList;
  int? ticketPrice;
  int? ticketSalePrice;

  ProductScheduleVo(
      {this.prdId,
        this.dplId,
        this.productName,
        this.productDisplayName,
        this.reserveDt,
        this.riderCount,
        this.timeList,
        this.ticketPrice,
        this.ticketSalePrice});

  ProductScheduleVo.fromJson(Map<String, dynamic> json) {
    prdId = json['prdId'];
    dplId = json['dplId'];
    productName = json['productName'];
    productDisplayName = json['productDisplayName'];
    reserveDt = json['reserveDt'];
    riderCount = json['riderCount'];
    if (json['timeList'] != null) {
      timeList = <TimeItemVo>[];
      json['timeList'].forEach((v) {
        timeList!.add(new TimeItemVo.fromJson(v));
      });
    }
    ticketPrice = json['ticketPrice'];
    ticketSalePrice = json['ticketSalePrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prdId'] = this.prdId;
    data['dplId'] = this.dplId;
    data['productName'] = this.productName;
    data['productDisplayName'] = this.productDisplayName;
    data['reserveDt'] = this.reserveDt;
    data['riderCount'] = this.riderCount;
    if (this.timeList != null) {
      data['timeList'] = this.timeList!.map((v) => v.toJson()).toList();
    }
    data['ticketPrice'] = this.ticketPrice;
    data['ticketSalePrice'] = this.ticketSalePrice;
    return data;
  }
}


