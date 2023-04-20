import 'package:admin/HomePage.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/controllers/SideMenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/dashboard/hierarchy_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Consumer<SideMenuController>(
                  builder: (context, controller, child) {
                if (controller.selected == MenuEnum.Dashboard) {
                  return DashboardScreen();
                } else if (controller.selected == MenuEnum.Hierarchy) {
                  return HierarchyScreen();
                } else {
                  return DashboardScreen();
                }
              }),
              // child: Homepage(),
            ),
          ],
        ),
      ),
    );
  }
}
