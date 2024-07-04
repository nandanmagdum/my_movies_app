  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appButton({required BuildContext context, required String text}) {
    return Material(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.grey[850],
                  elevation: 5.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: MediaQuery.of(context).size.width*0.8,
                    decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(10.r)
                    ),
                    child: Center(child: Text(text, style: TextStyle(fontSize: 22.sp),),),
                  ),
                );
  }