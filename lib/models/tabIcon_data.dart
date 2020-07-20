import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/images/app/invoices-1.png',
      selectedImagePath: 'assets/images/app/invoices-2.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/app/my-account-1.png',
      selectedImagePath: 'assets/images/app/my-account-2.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/app/my-store-1.png',
      selectedImagePath: 'assets/images/app/my-store-2.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/app/user-1.png',
      selectedImagePath: 'assets/images/app/user-2.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
