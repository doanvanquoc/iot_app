import 'package:get/get.dart';


// ignore: camel_case_types
class viewModel extends GetxController{
  var currentIndex=0.obs;
  var checkState=false.obs;
  var selectedState=0.obs;

  void onHandelSwitch(pres)
  {
    checkState.value=pres;
  }
  void onTapRoom(index)
  {
    selectedState.value=index;
  }
 
} 