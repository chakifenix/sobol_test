import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sobol_test/controllers/auth.dart';
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

  final _formKey = GlobalKey<FormState>();

  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List page = [
      Registration(
        formkey: _formKey,
        phoneText: phoneNumber,
        onIndexChanged: () {
          if (_formKey.currentState!.validate()) {
            String cleanedNumber =
                phoneNumber.text.replaceAll(RegExp(r'[\s()-]'), '');
            AuthService.sentOtp(
                phone: cleanedNumber,
                errorStep: () =>
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Error in sending OTP",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    )),
                nextStep: () {
                  setState(() {
                    currentIndex = 1;
                    firstPage = false;
                    firstPagePassed = true;
                    secondPage = true;
                  });
                });
          }
        },
      ),
      SendOtp(phoneText: phoneNumber)
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: const Color(0xFFFBFBFB),
          elevation: 0,
          leading: const BackButton(
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
                        ? const Color(0xFFFFB700)
                        : (secondPage)
                            ? Colors.transparent
                            : (thirdPage)
                                ? Colors.transparent
                                : null,
                    shape: BoxShape.circle),
                child: Center(
                    child: (firstPage)
                        ? const Text('1')
                        : (secondPage)
                            ? const Text('')
                            : (thirdPage)
                                ? const Text('')
                                : null),
              ),
              Column(
                children: [
                  Container(
                    width: 44,
                    height: 1,
                    decoration: const BoxDecoration(color: Color(0xFFEBEBEB)),
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
                    color: (secondPage)
                        ? const Color(0xFFFFB700)
                        : const Color(0xFFEBEBEB),
                    shape: BoxShape.circle),
                child: const Center(child: Text('2')),
              ),
              Column(
                children: [
                  Container(
                    width: 44,
                    height: 1,
                    decoration: const BoxDecoration(color: Color(0xFFEBEBEB)),
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
                    color: (thirdPage)
                        ? const Color(0xFFFFB700)
                        : const Color(0xFFEBEBEB),
                    shape: BoxShape.circle),
                child: const Center(child: Text('3')),
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
