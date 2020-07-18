import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ListContainer.dart';
import 'animatefFlutter.dart';
void main() {
  runApp(MyApp());
}





class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int firstVal=0;
  int secondVal=0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_)=>QuotesFinder(),
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
          home:Scaffold(
              backgroundColor:Colors.black45,
           body:AnimateFlutter(height:250,width:600,fontSize:25,firstVal:firstVal,secondVal:secondVal)
         , floatingActionButton:FloatingActionButton(
           onPressed: () {
           setState(() {
             firstVal=secondVal;
                secondVal++;
                print("${firstVal}---------${secondVal}");
           });
         },backgroundColor:Colors.transparent,
          child:Container(

            decoration:BoxDecoration(
              border:Border.all(
                color:Colors.orange
              ),
              borderRadius:BorderRadius.circular(50),
            ),

            child:Icon(Icons.navigate_next),
          ),

         )
       )
      ),
    );
  }
}
