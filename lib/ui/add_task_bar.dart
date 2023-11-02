import 'package:flutter/material.dart';
import 'package:flutter_miniproject_dinda/ui/theme.dart';
import 'package:flutter_miniproject_dinda/ui/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _endTime="11:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body:Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: HeadingStyle,),
              MyInputField(title: "Title", hint: "Enter your title"),
              MyInputField(title: "Note", hint: "Enter your title"),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget:IconButton(
                icon:Icon(Icons.calendar_today_outlined,
                  color:Colors.grey,
                ),
                onPressed: (){
                    print("Hi there");
                    _getDateFromUser();
                },

              )),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                    title: "Start Date", 
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFormUser(isStartTime: true);
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ),

                  SizedBox(width: 12,),

                  Expanded(
                    child: MyInputField(
                    title: "End Date", 
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFormUser(isStartTime: false);
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                      ),
                    ))
              ],
              )


            ],
            ),
        ),
      )
    );
  }

  _appBar(BuildContext context){

    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor ,
      leading: GestureDetector(
        onTap:(){
            Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
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

  _getDateFromUser()async {
    DateTime? _pickerDate = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2015), 
      lastDate: DateTime(2026)
    );

    if(_pickerDate!=null){
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    }else{
      print("it's null or something is wrong");
    }
  }

  _getTimeFormUser({required bool isStartTime}) async {
    var pickedTime =await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime==null){
    print("Time canceld");
    }else if(isStartTime==true){
      setState(() {
        _startTime:_formatedTime;
      });                                                                                                                                                                                
    }else if(isStartTime==false){
      setState(() {
        _endTime:_formatedTime;
      });
    }
  }

  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context, 
      initialTime: TimeOfDay(
        //_startTime --> 10.30 AM
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0],)
      )
    
    );
  }
}