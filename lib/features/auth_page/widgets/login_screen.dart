import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Registration extends StatefulWidget {
  final void Function()? onIndexChanged;
  final GlobalKey<FormState> formkey;
  final TextEditingController phoneText;
  const Registration(
      {super.key,
      this.onIndexChanged,
      required this.formkey,
      required this.phoneText});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final maskFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
  );

  bool phoneNumberFilled = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        children: [
          const Text(
            'Регистрация',
            style: TextStyle(
              color: Color(0xFF4E4E4E),
              fontSize: 34,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          SizedBox(
              width: 199.w,
              child: Text(
                'Введите номер телефона для регистрации',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF4E4E4E),
                  fontSize: 15.sp,
                  fontFamily: 'SF Pro Text',
                  fontWeight: FontWeight.w400,
                ),
              )),
          SizedBox(
            height: 38.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Номер телефона',
                style: TextStyle(
                  color: const Color(0xFF4E4E4E),
                  fontSize: 12.sp,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 2.w,
              ),
              Form(
                key: widget.formkey,
                child: TextFormField(
                  onChanged: (value) {
                    if (value.length == 18) {
                      setState(() {
                        phoneNumberFilled = true;
                      });
                    } else {
                      setState(() {
                        phoneNumberFilled = false;
                      });
                    }
                  },
                  controller: widget.phoneText,
                  inputFormatters: [maskFormatter],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide:
                              const BorderSide(color: Color(0xFFFFB700)))),
                  validator: (value) {
                    if (value!.length != 18) return "Invalid phone number";
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120.h,
          ),
          CupertinoButton(
              color: phoneNumberFilled
                  ? const Color(0xFFFFB700)
                  : const Color(0xFFA7A7A7),
              onPressed: widget.onIndexChanged,
              child: const Text(
                'Отправить смс-код',
                style: TextStyle(color: Color(0xFF4E4E4E)),
              )),
          SizedBox(
            width: 232.w,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Нажимая на данную кнопку, вы даете согласие на обработку ',
                    style: TextStyle(
                      color: const Color(0xFFA7A7A7),
                      fontSize: 10.sp,
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'персональных данных',
                    style: TextStyle(
                      color: const Color(0xFFFFB700),
                      fontSize: 10.sp,
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
