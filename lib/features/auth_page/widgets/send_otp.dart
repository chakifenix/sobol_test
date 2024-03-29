import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:sobol_test/controllers/auth.dart';
import 'package:sobol_test/features/home_page/view/home_screen.dart';

class SendOtp extends StatelessWidget {
  SendOtp({super.key, required this.phoneText});
  final TextEditingController phoneText;
  final TextEditingController otpController = TextEditingController();

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    const defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 3, color: Color(0xFFA7A7A7)),
      )),
    );

    return Column(
      children: [
        const Text('Подтверждение'),
        SizedBox(
          height: 24.h,
        ),
        SizedBox(
            width: 268.w,
            child: Text(
                'Введите код, который мы отправили в SMS на ${phoneText.text}')),
        SizedBox(
          height: 20.h,
        ),
        Pinput(
          length: 6,
          pinAnimationType: PinAnimationType.slide,
          controller: otpController,
          focusNode: focusNode,
          defaultPinTheme: defaultPinTheme,
          onCompleted: (value) {
            AuthService.loginWithOtp(otp: otpController.text).then((value) {
              if (value == "Success") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value),
                  backgroundColor: Colors.red,
                ));
              }
            });
          },
        ),
        SizedBox(
          height: 48.h,
        ),
        GestureDetector(
          onTap: () {
            String cleanedNumber =
                phoneText.text.replaceAll(RegExp(r'[\s()-]'), '');
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
                nextStep: () {});
          },
          child: const Text(
            'Отправить код еще раз',
            style: TextStyle(
              color: Color(0xFFFFB700),
              fontSize: 15,
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
