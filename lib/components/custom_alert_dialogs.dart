import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomAlertDialogs{

  static Future<void> showSuccessDialog(BuildContext context,String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          insetAnimationDuration: const Duration(seconds: 1),
          insetAnimationCurve: Curves.fastOutSlowIn,
          elevation: 2,

          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   child: Lottie.asset(
                //     'assets/json/success.json',
                //     width: 200,
                //     height: 200,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Container(
                    child: Column(
                      children: [
                        Text("successfull",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
                        Text(message,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                      ],
                    )

                ),
                Container(
                  margin: EdgeInsets.only(top:20,left: 20,right: 20,bottom: 20),
                  child: Divider(color: Colors.grey,),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    height: 40,
                    margin: EdgeInsets.only(left: 40,right: 40),
                    child:Text("okay",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w400),),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // static Future<void> showServiceSubmitDialog(BuildContext context,String message ) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: const BorderRadius.all(
  //             Radius.circular(30.0),
  //           ),
  //         ),
  //         insetAnimationDuration: const Duration(seconds: 1),
  //         insetAnimationCurve: Curves.fastOutSlowIn,
  //         elevation: 2,
  //
  //         child: Container(
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(30)
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               // Container(
  //               //   child: Lottie.asset(
  //               //     'assets/json/success.json',
  //               //     width: 200,
  //               //     height: 200,
  //               //     fit: BoxFit.cover,
  //               //   ),
  //               // ),
  //               Container(
  //                   child: Column(
  //                     children: [
  //                       Text("successful",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
  //                       Text(message,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
  //                     ],
  //                   )
  //
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(top:20,left: 20,right: 20,bottom: 20),
  //                 child: Divider(color: Colors.grey,),
  //               ),
  //               GestureDetector(
  //                 onTap: (){
  //                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
  //                       HomePage()), (Route<dynamic> route) => false);
  //                 },
  //                 child: Container(
  //                   alignment: Alignment.center,
  //                   width: double.maxFinite,
  //                   height: 40,
  //                   margin: EdgeInsets.only(left: 40,right: 40),
  //                   child:Text(TextItem.okay,style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w400),),
  //                   decoration: BoxDecoration(
  //                       color: Colors.green,
  //                       borderRadius: BorderRadius.circular(30)
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 15,
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  static Future<void> showFailuresDailog(BuildContext context,String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          insetAnimationDuration: const Duration(seconds: 1),
          insetAnimationCurve: Curves.fastOutSlowIn,
          elevation: 2,

          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   child: Lottie.asset(
                //     'assets/json/error.json',
                //     width: 200,
                //     height: 200,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Container(
                    child: Column(
                      children: [
                        Text("error",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
                        Text(error,textAlign: TextAlign.center,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                      ],
                    )

                ),
                Container(
                  margin: EdgeInsets.only(top:20,left: 20,right: 20,bottom: 20),
                  child: Divider(color: Colors.grey,),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    height: 40,
                    margin: EdgeInsets.only(left: 40,right: 40),
                    child:Text("okay",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w400),),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // static Future<bool> showAppClosingWarning(BuildContext context) async {
  //     return await showDialog<bool>(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text('Are you sure?'),
  //         content: Text('Do you want to exit the App'),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             onPressed: () => Navigator.of(context).pop(false),
  //             child: Text('No'),
  //             style: ElevatedButton.styleFrom(
  //               primary: kPrimaryColor, // Change the background color here
  //             ),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               //Navigator.of(context).pop(true);
  //               // Close the app
  //               SystemNavigator.pop();
  //             },
  //             child: Text('Yes'),
  //             style: ElevatedButton.styleFrom(
  //               primary: kPrimaryColor, // Change the background color here
  //             ),
  //           ),
  //         ],
  //       ),
  //     ) ?? false;
  //   }
}