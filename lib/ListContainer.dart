import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class QuotesFinder extends ChangeNotifier{
  //Get Quotes from Web
  //Getter and Setter
  //Setter - should Be a list of course
  //Provider - Class in the setter and getter
  //When it is triggered it will be get more quotes...
 List<Map<String,String>>_QuoteList=[
   {
     "Quotes":"Life sometimes leaves No one Unfucked",
     "Author":"Jesinth Arnold"
   }

   ];
  Future<void> getQuotes() async{
        final random_Quotes=await http.get("https://programming-quotes-api.herokuapp.com/quotes/random").then(
                (value){
                  Map<String,dynamic>_updatedQuotes=jsonDecode(value.body);
                  _QuoteList.add({
                    "Quotes":_updatedQuotes["en"],
                    "Author":_updatedQuotes["author"]
                  });
                  notifyListeners();
                }
                );
  }

  List<Map<String,dynamic>> get Qvalue{

    return [..._QuoteList];
  }





}