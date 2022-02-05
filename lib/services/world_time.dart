import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; //location name for ui
  late String time; //time in that location
  String flag; //url to an asset flaf item
  String url; //location url for api end point
  late bool isDaytime;

  WorldTime({required this.location,required this.flag,required this.url});

    Future<void> getTime() async{

    try{
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(dateTime);
      // print(offset);

      //create datetime object

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDaytime = now.hour>6 && now.hour<20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught an error $e');
      time = 'Could not get time data';
    }

  }

}