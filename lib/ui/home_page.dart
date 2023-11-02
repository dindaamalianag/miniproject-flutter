import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miniproject_dinda/service/notification_services.dart';
import 'package:flutter_miniproject_dinda/service/theme_services.dart';
import 'package:flutter_miniproject_dinda/ui/theme.dart';
import 'package:flutter_miniproject_dinda/ui/widgets/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'add_task_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
        ],
      ),
    );
  }

  _addDateBar(){
    return Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color:Colors.grey
                )
              ),
              dayTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color:Colors.grey
                )
              ),
              monthTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color:Colors.grey
                )
            ),
              onDateChange: (date){
                    _selectedDate=date;
              },
            ),
          );
  }
  _addTaskBar(){
    return Container(
            margin: const EdgeInsets.only(left:20, right: 20, top: 10),
            child: Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,  
              children: [
                Container(
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat.yMMMMd().format(DateTime.now()),  
                      style: subHeadingStyle,
                      ),
                       Text("Today",
                       style: HeadingStyle,
                       )
                    ],
                  ),
                ),
                MyButton(label: "+ Add Task", onTap: ()=>Get.to(AddTaskPage()))

              ],
              ),
          );
}

  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor ,
      leading: GestureDetector(
        onTap:(){
            ThemeService().switchTheme();
            notifyHelper.displayNotification(
              title:"Theme Changed",
              body: Get.isDarkMode?"Activated Dark Theme":"Activated Light Theme"
            );

            notifyHelper.scheduledNotification();
        },
        child: Icon(Get.isDarkMode ?Icons.wb_sunny_outlined:Icons.nightlight_round,
        size: 20,
        color:Get.isDarkMode ? Colors.white:Colors.black
        ),  
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage( 
            "Assets/images/potoku.png"
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }
}



