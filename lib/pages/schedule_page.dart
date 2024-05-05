import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../controller/schedule_controller.dart';
import '../service/helper.dart';
import '../vo/product_schedule_vo.dart';

///SchedulePage
///담당자 : saran

class SchedulePage extends StatefulWidget {

  final String productName;

  const SchedulePage({Key? key ,required this.productName}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  @override
  void initState() {
    super.initState();
    logger.i("SchedulePage");

    //처음값을 세팅해줌 이용가는한 월 중에 제일 처음, 이용가능한 일중에 제일처음 세팅
    Future.delayed(Duration.zero, () async {
      final scheduleController = Provider.of<ScheduleController>(context, listen: false);
      productScheduleVo = await scheduleController.getTimeList(scheduleController.selectedMonth!.dateList![0].date!, "code");
      setState(() {
        selectedDate = productScheduleVo!.reserveDt!;
      });
    });
  }

  //선택된 날짜, 페이지 들어오면 Initstate에 의해 제일처음날짜로 세팅됨
  String selectedDate = "";

  //선택된 날짜중에 선택된 timeSlot
  String? selectedTime;

  //선택된 날짜의 timeslot 및 기타 정보
  ProductScheduleVo? productScheduleVo;


  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleController>(
      builder: (context,scheduleController,child) {
        return Scaffold(
          appBar: AppBar(title: Text("날짜 시간 선택"),),
          body: Column(

            children: [
              //유저 선택 진행 상태
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.pinkAccent
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check,size: 13,color: Colors.white,),
                              SizedBox(width: 5,),
                              Text("티켓선택",style: TextStyle(fontSize: 10,height: 1,color: Colors.white),)
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: [
                              Icon(Icons.circle,size: 3,),
                              SizedBox(width: 2,),
                              Icon(Icons.circle,size: 3,),
                            ],
                          ),
                        ),

                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.pinkAccent),
                            color: Colors.white
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 9,
                                backgroundColor: Colors.pinkAccent, // 배경색 설정
                                child: Icon(Icons.calendar_month, color: Colors.white,size: 12,), // 아이콘과 아이콘 색상
                              ),
                              SizedBox(width: 5,),
                              Text("시간선택",style: TextStyle(fontSize: 10,height: 1,color: Colors.pinkAccent),),
                              SizedBox(width: 5,),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: [
                              Icon(Icons.circle,size: 3,color: Colors.grey.withOpacity(0.5),),
                              SizedBox(width: 2,),
                              Icon(Icons.circle,size: 3,color: Colors.grey.withOpacity(0.5),),
                            ],
                          ),
                        ),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey.withOpacity(0.5)),
                              color: Colors.white
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 9,
                                backgroundColor: Colors.grey.withOpacity(0.5), // 배경색 설정
                                child: Icon(Icons.currency_yen, color: Colors.white,size: 12,), // 아이콘과 아이콘 색상
                              ),
                              SizedBox(width: 5,),
                              Text("결제하기",style: TextStyle(fontSize: 10,height: 1,color: Colors.grey.withOpacity(0.5)),),
                              SizedBox(width: 5,),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),

              //월 및 날짜
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 20,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: scheduleController.availableDateGroup.length,
                              itemBuilder: (buildContext,index){
                                return scheduleController.availableDateGroup[index].dateList!.length==0
                                    //해당월에 이용가능한 날짜가 한개도 없으면 월도 표현안해줌
                                    ? SizedBox()
                                    : GestureDetector(
                                  onTap: (){
                                    scheduleController.changeSelectedMonth(index);
                                    setState(() {
                                      selectedDate = "";
                                      selectedTime = null;
                                      productScheduleVo= null;
                                    });
                                  },
                                  child: Container(
                                    width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: scheduleController.selectedMonth?.month == scheduleController.availableDateGroup[index].month
                                            ?Colors.pinkAccent
                                            :Colors.white,
                                      ),

                                      child: Center(child: Text(scheduleController.availableDateGroup[index].month.toString()+"월"))),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 10,
                                );
                              },
                            ),
                          ),
                        ),
                        Text(selectedDate)
                      ],
                    ),
                    SizedBox(height: 10,),
                    (scheduleController.selectedMonth != null && scheduleController.selectedMonth!.dateList !=null) ?Container(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: scheduleController.selectedMonth!.dateList!.length,
                        itemBuilder: (buildContext,index){
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () async{
                                  ProductScheduleVo data =await scheduleController.getTimeList(scheduleController.selectedMonth!.dateList![index].date!, "code");
                                  setState(() {
                                    selectedTime = null;
                                    productScheduleVo = data ;
                                    selectedDate = scheduleController.selectedMonth!.dateList![index].date!;
                                  });
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:
                                    selectedDate == scheduleController.selectedMonth!.dateList![index].date
                                        ? Colors.pinkAccent
                                        : Colors.transparent,
                                  ),
                                  child: Center(child: Text(
                                      scheduleController.selectedMonth!.dateList![index].day.toString()),
                                  ),
                                ),
                              ),

                              SizedBox(height: 5,),
                              Text(
                                scheduleController.selectedMonth!.dateList![index].dayOfKorean.toString(),
                                style: TextStyle(fontSize: 9,color: scheduleController.selectedMonth!.dateList![index].dayOfKorean == "일"?Colors.red: Colors.black),),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 20,
                          );
                        },
                      ),
                    ):SizedBox()
                  ],
                ),
              ),

              //상품이름 , 앞페이지에서 파라메터로 넘겨주는 형태
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                child: Row(
                  children: [
                    Text(widget.productName),
                  ],
                ),
              ),

              //타임슬롯
              Expanded(
                child:productScheduleVo==null
                    ?SizedBox()
                    :productScheduleVo!.timeList!.length == 0
                    ? Text("선택가능한 타임이 없어요")
                    : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 그리드 열 수
                        childAspectRatio: 16/9,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                      // index에 따라 각 아이템을 생성
                      return GestureDetector(
                        onTap: (){
                          if(productScheduleVo!.timeList![index].enabled!){
                            setState(() {
                              selectedTime = productScheduleVo!.timeList![index].timeSlot;
                            });
                          }else{
                            //경고메세지

                          }

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:selectedTime == productScheduleVo!.timeList![index].timeSlot
                                    ?Colors.pinkAccent
                                    : Colors.grey.withOpacity(0.5)
                            ),
                            color: productScheduleVo!.timeList![index].enabled!?Colors.white:Colors.grey.shade300
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  productScheduleVo!.timeList![index].timeSlot.toString(),
                                style: TextStyle(color:productScheduleVo!.timeList![index].enabled!?Colors.black: Colors.grey),
                              ),
                              Text(
                                  productScheduleVo!.timeList![index].stockStatusStr.toString(),
                                style: TextStyle(color:getTextColor(productScheduleVo!.timeList![index].stockStatus!)),
                              ),
                            ],
                          ),
                        ),
                      ); // 여기서 YourGridItemWidget은 각 그리드 아이템을 나타내는 위젯입니다.
                                    },
                                    itemCount: productScheduleVo!.timeList!.length
                                    , // 그리드에 표시할 전체 아이템 수
                                  ),
                    ),
              ),

              //이전 , 다음
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        color: Colors.grey,
                        child: Center(child: Text("이전")),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: (){
                        if(selectedTime!=null){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                insetPadding: EdgeInsets.zero,
                                content: Container(
                                  width: 0,
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                          )
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("상품명"),
                                            Text(productScheduleVo!.productName!),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                          )
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("날짜 시간"),
                                            Text(selectedDate+"("+ getKoreanWeekday(selectedDate)+")" + " / "+ selectedTime!),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            )
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("구매 인원"),
                                            Text(productScheduleVo!.riderCount.toString() +"명"),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("총합계", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                                            Text(formatNumber(productScheduleVo!.ticketSalePrice!)+"원", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              );

                            },
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        color: selectedTime==null?Colors.yellow.withOpacity(0.5) :Colors.yellow,
                        child: Center(child: Text("다음")),
                      ),
                    ),
                  ),
                ],
              )

            ],
          ),
        );
      }
    );
  }
}
