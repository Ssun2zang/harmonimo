import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonimo/MyController.dart';


class DiseaseSelectionPage extends StatefulWidget {
  @override
  State<DiseaseSelectionPage> createState() => _DiseaseSelectionPageState();
}

class _DiseaseSelectionPageState extends State<DiseaseSelectionPage> {
  final diseaseController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("본인 위험 질환 등록",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),backgroundColor: Colors.white,centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),),
      body: Column(
        children: [
          Container(child: Text('위험을 대비하여 본인이 가지고 있는 위험 질환을\n미리 등록해놓으면 좋아요 !\n자신과 친구만 볼 수 있으며, 위험시에만 표시되어\n빠른 치료를 도와요 !',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),textAlign: TextAlign.center,),),
          Container(child: Text('※ 추후에도 등록이 가능해요 !',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),textAlign: TextAlign.center,)),
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  color: Color(0xffe3eecf),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 500,
                child: ListView.builder(
                  itemCount: diseaseController.allDiseases.length,
                  itemBuilder: (context, index) {
                    final disease = diseaseController.allDiseases[index];
                    return CheckboxListTile(
                      activeColor: Colors.green,
                      title: Text(disease,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                      value: diseaseController.selectedDiseaseIndexes.contains(index),
                      onChanged: (newValue) {
                        setState(() {
                          diseaseController.toggleDisease(index);
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // Print selected diseases
          Get.back();
          print(diseaseController.selectedDiseaseIndexes);
        },
        child: Text('선택 완료',style: TextStyle(color: Colors.black)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFA9CC60)), // 배경색 지정
        ),
      ),
    );
  }
}
