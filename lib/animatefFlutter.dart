import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation/ListContainer.dart';
import 'package:provider/provider.dart';

// ignore: non_constant_identifier_names
Widget UpContainer(String Digit,[double height,double width,double fontSize]){
  return Container(

    height:height??100,
    width:width??100,
    decoration:BoxDecoration(
      color:Colors.black,
      border:Border.all(
        color:Colors.orange,
        width:5.0
      ),
      borderRadius:BorderRadius.all(
          Radius.circular(20.0)
      )
    ),
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(Digit.toString(),style:TextStyle(
            color:Colors.white,
            fontSize:fontSize??100
        ),),
      ),
    ),
  );
}
class AnimateFlutter extends StatefulWidget {
  final List<Map<String,dynamic>> name;
  final double height;
  final double width;
  final double  fontSize;
  final int firstVal;
  final int secondVal;
  AnimateFlutter({this.name,this.height,this.width,this.fontSize,@required this.firstVal,@required this.secondVal});
  @override
  _AnimateFlutterState createState() => _AnimateFlutterState();
}
class _AnimateFlutterState extends State<AnimateFlutter> with SingleTickerProviderStateMixin {
  AnimationController _animateControl1;
  Animation _animation1;
  bool isRunning=false;
  final cod_value=0.0005;
//  Timer _timer;
  final double _zeroAngle=0.0001;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom
    ]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft
  ]);
    _animateControl1=AnimationController(vsync:this,duration:Duration(milliseconds:500));
    _animation1=Tween<double>(begin:0.0001,end:math.pi/2).animate(_animateControl1)..addListener(() {
      setState(() {

    });
    })..addStatusListener((status) {
      if(status ==AnimationStatus.completed){
        setState(() {
          isRunning=true;
          _animateControl1.reverse();

        });
      }
    });


//    if(secondVal != widget.name.length-1){
//      _timer = Timer.periodic(Duration(seconds: 2), (timer) {
//        setState(() {
////          print("${first_val}-${second_val}");
//          if (secondVal == widget.name.length - 1) {
//            _timer.cancel();
//          }
//          else {
////            print("Second_value  ${first_val}--${second_val}");
//            _animateControl1.forward();
//            isRunning = false;
//            firstVal = secondVal;
//            secondVal += 1;
//          }
//        });
//      });
//
//    }
//    else {
//      _timer.cancel();
//    }





  }



  @override
  void didUpdateWidget(AnimateFlutter oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {
      isRunning=false;
    });


    _animateControl1.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animateControl1.dispose();
  }




  @override
  Widget build(BuildContext context) {
    Provider.of<QuotesFinder>(context,listen:false).getQuotes();
    final countList=Provider.of<QuotesFinder>(context,listen:false).Qvalue;
    print("------------------------");
    print(countList[widget.secondVal]["Quotes"]);
    print("------------------------");
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);


    return Padding(
      padding:EdgeInsets.only(top:MediaQuery.of(context).size.height/4.5),

      child: Column(
        children: <Widget>[
                   Stack(children: <Widget>[
                     //------------------------------------------------------------------------------------------------
                     Transform(
                       transform:Matrix4.identity()..setEntry(3,2,cod_value)..rotateX(_zeroAngle),
                       child:ClipRect(
                         child:Align(
                           alignment:Alignment.topCenter,
                           heightFactor:0.5,
                           child:UpContainer(countList[widget.firstVal]["Quotes"],widget.height,widget.width,widget.fontSize),
                         ),
                       ),
                     ),
                     //------------------------------------------------------------------------------------------------
                     Transform(
                       origin:Offset(widget.height/2,widget.height/2),
                       transform:Matrix4.identity()..setEntry(3,2,cod_value)..rotateX(isRunning?_animation1.value:math.pi/2),
                       child:ClipRect(
                         child:Align(
                           alignment:Alignment.topCenter,
                           heightFactor:0.5,
                           child:UpContainer(countList[widget.secondVal]["Quotes"],widget.height,widget.width,widget.fontSize),

                         ),
                       ),
                     )
                   ],),



          //------------------------------------------------------------------------------------------------
                   Padding(padding:EdgeInsets.only(top:3.0),),
          //------------------------------------------------------------------------------------------------




          Stack(children: <Widget>[
                     //------------------------------------------------------------------------------------------------
                     Transform(
                           transform:Matrix4.identity()..setEntry(3,2,cod_value)..rotateX(_zeroAngle),
                            child:ClipRect(
                                           child:Align(
                                            alignment:Alignment.bottomCenter,
                                             heightFactor:0.5,
                                             child:UpContainer(countList[widget.secondVal]["Quotes"],widget.height,widget.width,widget.fontSize),
                                           ),
                                          ),
                     ),
                     //------------------------------------------------------------------------------------------------

                     Transform(
                       transform:Matrix4.identity()..setEntry(3,2,cod_value)..rotateX(isRunning?math.pi/2:-_animation1.value),
                       child:ClipRect(
                         child:Align(
                           alignment:Alignment.bottomCenter,
                           heightFactor:0.5,
                           child:UpContainer(countList[widget.firstVal]["Quotes"],widget.height,widget.width,widget.fontSize),
                         ),
                       ),
                     ),
                     //------------------------------------------------------------------------------------------------
          ],),
        ],
      ),
    );

  }
}
