// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:food_animation/painters/circles_painter.dart';
// import 'package:food_animation/utils/helper.dart';
// import 'package:food_animation/views/home_view.dart';
// import 'package:google_fonts/google_fonts.dart';

// class FoodBox extends StatelessWidget {
//   final Animation<double> growAnimation;
//   final Animation<double> shrinkAnimation;
//   final Animation<double> progressAnimation;
//   final int index;
//   final void Function()? onTap;
//   final double minHeight;
//   final double maxHeight;
//   final double boxWidth;
//   final int? previousIndex;
//   final int currIndex;

//   final double visiblePortion;

//   static const double IMAGE_HEIGHT = 150.0;

//   const FoodBox(
//       {required this.onTap,
//       required this.index,
//       required this.growAnimation,
//       required this.shrinkAnimation,
//       required this.minHeight,
//       required this.maxHeight,
//       required this.boxWidth,
//       required this.previousIndex,
//       required this.currIndex,
//       required this.visiblePortion,
//       required this.progressAnimation,
//       super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           AnimatedBuilder(
//             animation: Listenable.merge([growAnimation, shrinkAnimation]),
//             builder: (BuildContext context, Widget? child) {
//               final progress = progressAnimation.value * visiblePortion;
//               final scale = 0.7 + (0.5 * progress);

//               final baseAngle = Helper.degreeToRadian(30);
//               final targetAngle = baseAngle - Helper.degreeToRadian(60);

//               double currentAngle;
//               if (currIndex == index) {
//                 currentAngle =
//                     baseAngle + (targetAngle - baseAngle) * growAnimation.value;
//               } else if (previousIndex == index) {
//                 currentAngle = targetAngle +
//                     (baseAngle - targetAngle) * shrinkAnimation.value;
//               } else {
//                 currentAngle =
//                     baseAngle + (-Helper.degreeToRadian(48) * visiblePortion);
//               }

//               double boxHeight = minHeight;
//               final slideX = 80.0 * (1 - progress);
//               final slideY = -50.0 * (2 - progress);

//               if (currIndex == index) {
//                 boxHeight =
//                     minHeight + ((maxHeight - minHeight) * growAnimation.value);
//               } else if (previousIndex == index) {
//                 boxHeight = minHeight +
//                     ((maxHeight - minHeight) * (1 - shrinkAnimation.value));
//               }

//               Color baseColor = boxContent[index].color;
//               Color lighterColor =
//                   HSLColor.fromColor(baseColor).withLightness(0.7).toColor();
//               Color darkerColor =
//                   HSLColor.fromColor(baseColor).withLightness(0.3).toColor();

//               return Stack(
//                 children: [
//                   Container(
//                     height: boxHeight,
//                     width: boxWidth,
//                     margin: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [lighterColor, darkerColor],
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   CustomPaint(
//                     size: Size(boxWidth, boxHeight),
//                     painter: CirclesPainter(baseColor),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 24.0, left: 34),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: boxHeight * 0.035,
//                               backgroundColor: Colors.white.withOpacity(0.3),
//                             ),
//                             SizedBox(width: boxWidth * 0.05),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Linda Miller",
//                                   style: GoogleFonts.lato(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                           ///min(max(boxHeight * 0.032, 14), 30),
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   "29 Jun",
//                                   style: GoogleFonts.lato(
//                                       fontSize: 30,
//                                           //min(max(boxHeight * 0.022, 12), 24),
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: boxHeight * 0.032,
//                         ),
//                         Container(
//                           height: 1,
//                           width: size.width * 0.55,
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           height: boxHeight * 0.028,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Text(
//                               "Spicy Maguro ",
//                               style: GoogleFonts.lato(
//                                   color: Colors.white,
//                                   fontSize: min(max(boxHeight * 0.06, 18), 35),
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(width: 20),
//                             const Icon(
//                               CupertinoIcons.heart_fill,
//                               color: Colors.black,
//                             )
//                           ],
//                         ),
//                         Text(
//                           "Rich Nutrition",
//                           style: GoogleFonts.lato(
//                               color: Colors.white,
//                               fontSize: min(max(boxHeight * 0.045, 16), 25),
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.symmetric(vertical: 20),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.15),
//                                 offset: const Offset(0, 10),
//                                 blurRadius: 10,
//                                 spreadRadius: 3,
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 CupertinoIcons.add_circled_solid,
//                                 size: boxHeight * 0.03,
//                               ),
//                               const SizedBox(width: 7),
//                               Text(
//                                 "Add to bag",
//                                 style: GoogleFonts.lato(
//                                     fontSize:
//                                         min(max(boxHeight * 0.01, 14), 24),
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                       bottom: size.height * 0.1 + slideY,
//                       left: (-40) + slideX,
//                       child: Hero(
//                           tag: boxContent[index].asset,
//                           child: SizedBox(
//                             width: boxHeight * 0.5,
//                             child: Transform.rotate(
//                               angle: currentAngle,
//                               child: Image.asset(
//                                   key: ValueKey(boxContent[index].asset),
//                                   filterQuality: FilterQuality.high,
//                                   fit: BoxFit.cover,
//                                   height: boxHeight * 0.5,
//                                   boxContent[index].asset),
//                             ),
//                           ))),
//                 ],
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }


