import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder/config/constant/app_constants.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(kLightGrey.value),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.85,
                    child: Row(children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(kOrange.value),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Icon(
                          Icons.search,
                          color: Color(kLight.value),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Search For Jobs',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(kOrange.value)),
                      ),
                      SizedBox(
                        width: 130.w,
                      ),
                    ]),
                  ),
                ],
              ))),
    );
  }
}

