import 'package:worksaran981/vo/product_vo.dart';

class TimeItemVo {
  String? timeSlot;
  String? stcDetailId;
  Null? stockStartTime;
  Null? stockEndTime;
  bool? stockUseYn;
  int? stockCount;
  int? totStockCount;
  bool? enabled;
  Null? operationStopYn;
  Null? appOnlyYn;
  List<ProductVo>? productDetailList;
  Null? optionList;
  String? stockStatusStr;
  int? stockStatus;

  TimeItemVo(
      {this.timeSlot,
        this.stcDetailId,
        this.stockStartTime,
        this.stockEndTime,
        this.stockUseYn,
        this.stockCount,
        this.totStockCount,
        this.enabled,
        this.operationStopYn,
        this.appOnlyYn,
        this.productDetailList,
        this.optionList,
        this.stockStatusStr,
        this.stockStatus});

  TimeItemVo.fromJson(Map<String, dynamic> json) {
    timeSlot = json['timeSlot'];
    stcDetailId = json['stcDetailId'];
    stockStartTime = json['stockStartTime'];
    stockEndTime = json['stockEndTime'];
    stockUseYn = json['stockUseYn'];
    stockCount = json['stockCount'];
    totStockCount = json['totStockCount'];
    enabled = json['enabled'];
    operationStopYn = json['operationStopYn'];
    appOnlyYn = json['appOnlyYn'];
    if (json['productDetailList'] != null) {
      productDetailList = <ProductVo>[];
      json['productDetailList'].forEach((v) {
        productDetailList!.add(new ProductVo.fromJson(v));
      });
    }
    optionList = json['optionList'];
    stockStatusStr = json['stockStatusStr'];
    stockStatus = json['stockStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeSlot'] = this.timeSlot;
    data['stcDetailId'] = this.stcDetailId;
    data['stockStartTime'] = this.stockStartTime;
    data['stockEndTime'] = this.stockEndTime;
    data['stockUseYn'] = this.stockUseYn;
    data['stockCount'] = this.stockCount;
    data['totStockCount'] = this.totStockCount;
    data['enabled'] = this.enabled;
    data['operationStopYn'] = this.operationStopYn;
    data['appOnlyYn'] = this.appOnlyYn;
    if (this.productDetailList != null) {
      data['productDetailList'] =
          this.productDetailList!.map((v) => v.toJson()).toList();
    }
    data['optionList'] = this.optionList;
    data['stockStatusStr'] = this.stockStatusStr;
    data['stockStatus'] = this.stockStatus;
    return data;
  }
}