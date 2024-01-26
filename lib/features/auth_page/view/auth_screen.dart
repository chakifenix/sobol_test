import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:sobol_test/features/auth_page/widgets/login_screen.dart';
import 'package:sobol_test/features/auth_page/widgets/send_otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int currentIndex = 0;
  bool firstPage = true;
  bool firstPagePassed = false;
  bool secondPage = false;
  bool thirdPage = false;

  @override
  Widget build(BuildContext context) {
    List page = [
      Registration(
        onIndexChanged: () {
          setState(() {
            currentIndex = 1;
            firstPage = false;
            firstPagePassed = true;
            secondPage = true;
          });
        },
      ),
      SendOtp()
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Color(0xFFFBFBFB),
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: (secondPage)
                            ? Colors.green
                            : (thirdPage)
                                ? Colors.green
                                : Colors.transparent),
                    color: (firstPage)
                        ? Color(0xFFFFB700)
                        : (secondPage)
                            ? Colors.transparent
                            : (thirdPage)
                                ? Colors.transparent
                                : null,
                    shape: BoxShape.circle),
                child: Center(
                    child: (firstPage)
                        ? Text('1')
                        : (secondPage)
                            ? Text('')
                            : (thirdPage)
                                ? Text('')
                                : null),
              ),
              Column(
                children: [
                  Container(
                    width: 44,
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xFFEBEBEB)),
                  ),
                  (firstPagePassed)
                      ? SvgPicture.asset('images/icon.svg')
                      : SizedBox(
                          height: 20.h,
                        )
                ],
              ),
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                    color: (secondPage) ? Color(0xFFFFB700) : Color(0xFFEBEBEB),
                    shape: BoxShape.circle),
                child: Center(child: Text('2')),
              ),
              Column(
                children: [
                  Container(
                    width: 44,
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xFFEBEBEB)),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                    color: (thirdPage) ? Color(0xFFFFB700) : Color(0xFFEBEBEB),
                    shape: BoxShape.circle),
                child: Center(child: Text('3')),
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          page[currentIndex]
        ],
      ),
    );
  }
}
