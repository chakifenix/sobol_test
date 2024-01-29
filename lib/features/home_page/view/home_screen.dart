import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sobol_test/features/name_page/name_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    List pages = [const MyProject(), const Accaunt()];
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: const Color(0xFFE3E3E3),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.star_fill),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.clock_solid),
              label: 'Recents',
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return pages[index];
            },
          );
        });
  }
}

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

class Accaunt extends StatefulWidget {
  const Accaunt({super.key});

  @override
  State<Accaunt> createState() => _AccauntState();
}

class _AccauntState extends State<Accaunt> {
  File? _image;
  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  String name = 'Настроить';
  String surname = 'Настроить';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Аккаунт'),
        ),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                          message: const Text('Выберите фото'),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: const Text('Камера'),
                              onPressed: () {
                                Navigator.pop(context, 'Камера');
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: const Text('Галерея Фото'),
                              onPressed: () {
                                _getImageFromGallery();
                                Navigator.pop(context, 'Галерея Фото');
                              },
                            )
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: const Text('Закрыть'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 73,
                          height: 76,
                          decoration: const BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                          child: (_image == null)
                              ? SvgPicture.asset('images/head.svg')
                              : Image.file(_image!),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset('images/points.svg'))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    'apollo@gmail.com',
                    style: TextStyle(
                      color: const Color(0xFF7D7D7D),
                      fontSize: 12.sp,
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(13.r),
                            topRight: Radius.circular(13.r))),
                    child: Column(children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Name(
                                        title: 'Ваше Имя',
                                        hint: 'Ваше Имя',
                                      ))).then((value) {
                            setState(() {
                              name = value;
                            });
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Color(0xFFC6C6C8)))),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Имя'),
                              Row(
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      color: const Color(0xFFC6C6C8),
                                      fontSize: 16.sp,
                                      fontFamily: 'SF Pro Text',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFFC6C6C8),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Name(
                                        title: 'Ваша Фамилия',
                                        hint: 'Ваша Фамилия',
                                      ))).then((value) {
                            setState(() {
                              surname = value;
                            });
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Color(0xFFC6C6C8)))),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Фамилия'),
                              Row(
                                children: [
                                  Text(
                                    surname,
                                    style: TextStyle(
                                      color: const Color(0xFFC6C6C8),
                                      fontSize: 16.sp,
                                      fontFamily: 'SF Pro Text',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFFC6C6C8),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
