// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:job_finder/config/constant/app_constants.dart';
// import 'package:job_finder/config/constant/height_spacer.dart';
// import 'package:job_finder/config/constant/reusable_text.dart';
// import 'package:job_finder/config/constant/width_spacer.dart';

// class PopularJob extends StatelessWidget {
//   const PopularJob({
//     super.key,
//     this.onTap,
//   });

//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//         width: width * 0.6,
//         decoration: BoxDecoration(
//             color: Color(kLightGrey.value),
//             borderRadius: BorderRadius.circular(12)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   child: Icon(Icons.u_turn_left),
//                 ),
//                 WidthSpacer(size: 20),
//                 ReusableText(
//                     text: 'Google', fontSize: 28, color: Color(kDark.value))
//               ],
//             ),
//             HeightSpacer(size: 10),
//             ReusableText(
//                 text: 'Senior Developer',
//                 fontSize: 23,
//                 color: Color(kDark.value)),
//             HeightSpacer(size: 10),
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Color(kDark.value),
//                   radius: 15,
//                   child: Icon(
//                     Icons.location_on_outlined,
//                     color: Color(kLight.value),
//                   ),
//                 ),
//                 WidthSpacer(size: 20),
//                 ReusableText(
//                     text: 'Washing Ton DC',
//                     fontSize: 18,
//                     color: Color(kDarkGrey.value)),
//               ],
//             ),
//             HeightSpacer(size: 5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ReusableText(
//                     text: '70K', fontSize: 18, color: Color(kDark.value)),
//                 WidthSpacer(size: 10),
//                 ReusableText(
//                     text: '/monthly', fontSize: 18, color: Color(kDark.value)),
//                 WidthSpacer(size: 50),
//                 CircleAvatar(
//                   backgroundColor: Colors.black,
//                   radius: 15,
//                   child: Icon(
//                     Icons.chevron_right,
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
