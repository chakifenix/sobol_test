import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Name extends StatelessWidget {
  final String title;
  final String hint;
  Name({super.key, required this.title, required this.hint});
  final TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, name.text);
          return true;
        },
        child: SafeArea(
            child: Scaffold(
                body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: const Color(0xFFC6C6C8),
                fontSize: 16.sp,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none),
            ),
          ),
        ))),
      ),
    );
  }
}
