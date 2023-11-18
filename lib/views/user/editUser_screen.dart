import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';

class EditUserScreen extends StatelessWidget {
  const EditUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Thông tin tài khoản"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding:  const EdgeInsets.all(5),
          child: Column(
            children: [

              /// -- Hình đại diện
              Stack(
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child:  const Image(image: AssetImage('assets/images/logo.png'))),
                  ),
                  //Viền ngoài cùng
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.transparent,
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  //Icon camera
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: 
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(100), 
                        color: AppColor.primaryColor,
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 2.0,
                        ),

                      ),
                      child: const Icon(Icons.camera_alt_rounded, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              const Text("Anh Quân",style: TextStyle(fontSize: 24,color: Color.fromRGBO(72, 77, 81, 1),fontWeight: FontWeight.bold),),
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tên đăng nhập",style: TextStyle(fontSize: 18),),
                      const SizedBox(height: 5,),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.secondaryColor),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primaryColor),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text("Email",style: TextStyle(fontSize: 18),),
                      const SizedBox(height: 5,),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.secondaryColor),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primaryColor),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text("Số điện thoại",style: TextStyle(fontSize: 18),),
                      const SizedBox(height: 5,),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.secondaryColor),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primaryColor),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text("Mật khẩu",style: TextStyle(fontSize: 18),),
                      const SizedBox(height: 5,),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.secondaryColor),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primaryColor),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide.none,
                              ),
                              child:  const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 70,vertical: 12),
                                child: Text('Cập nhật',style: TextStyle(fontSize: 20,color: Colors.white),),
                            ),
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}