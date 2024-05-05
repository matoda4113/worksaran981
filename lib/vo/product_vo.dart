class ProductVo {
  int? prdDetailId;
  String? entranceStartTime;
  String? entranceEndTime;
  int? orderNo;

  ProductVo(
      {this.prdDetailId,
        this.entranceStartTime,
        this.entranceEndTime,
        this.orderNo});

  ProductVo.fromJson(Map<String, dynamic> json) {
    prdDetailId = json['prdDetailId'];
    entranceStartTime = json['entranceStartTime'];
    entranceEndTime = json['entranceEndTime'];
    orderNo = json['orderNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prdDetailId'] = this.prdDetailId;
    data['entranceStartTime'] = this.entranceStartTime;
    data['entranceEndTime'] = this.entranceEndTime;
    data['orderNo'] = this.orderNo;
    return data;
  }
}

