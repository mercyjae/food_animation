import 'package:animations_pratice/model/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class FoodWidget extends StatelessWidget {
  final Animation<double> growAnimation;
  final Animation<double> shrinkAnimation;
  final Animation<double> progressAnimation;
  final void Function()? onTap;
  final double minHeight;
  final double maxHeight;
  final double boxWidth;

  final int? previousIndex;
  final int index;
  final int currentIndex;
  final double visiblePortion;
  const FoodWidget(
      {super.key,
      required this.index,
      required this.growAnimation,
      required this.shrinkAnimation,
      required this.progressAnimation,
      this.previousIndex,
      required this.currentIndex,
      required this.visiblePortion,
      this.onTap,
      required this.minHeight,
      required this.maxHeight,
      required this.boxWidth});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    // double maxHeight = size.height * 0.7;
    // double minHeight = size.height * 0.5;
    // double boxWidth = size.width * 0.8;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
          animation: Listenable.merge([growAnimation, shrinkAnimation]),
          builder: (BuildContext context, Widget? child) {
            final progress = progressAnimation.value * visiblePortion;
            final scale = 0.7 + (0.5 * progress);

            final baseAngle = Helper.degreeToRadian(30);
            final targetAngle = baseAngle - Helper.degreeToRadian(60);

            double currentAngle;
            if (currentIndex == index) {
              currentAngle =
                  baseAngle + (targetAngle - baseAngle) * growAnimation.value;
            } else if (previousIndex == index) {
              currentAngle = targetAngle +
                  (baseAngle - targetAngle) * shrinkAnimation.value;
            } else {
              currentAngle =
                  baseAngle + (-Helper.degreeToRadian(48) * visiblePortion);
            }

            double boxHeight = minHeight;
            final slideX = 80.0 * (1 - progress);
            final slideY = -50.0 * (2 - progress);

            if (currentIndex == index) {
              boxHeight =
                  minHeight + ((maxHeight - minHeight) * growAnimation.value);
            } else if (previousIndex == index) {
              boxHeight = minHeight +
                  ((maxHeight - minHeight) * (1 - shrinkAnimation.value));
            }

            Color baseColor = foodModel[index].color;
            Color lighterColor =
                HSLColor.fromColor(baseColor).withLightness(0.7).toColor();
            Color darkerColor =
                HSLColor.fromColor(baseColor).withLightness(0.3).toColor();

            return Stack(
              children: [
                Container(
                  height: boxHeight,
                  width: boxWidth,
                  // height: size.height * 0.7,
                  // width: size.width * 0.8,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: foodModel[index].color,
                    // gradient: const LinearGradient(
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    //   colors: [Colors.red, Colors.blue],
                    // ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, left: 34),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Image.asset(
                                foodModel[index].image,
                                fit: BoxFit.contain,
                              ),
                              // boxHeight * 0.035,
                              backgroundColor: Colors.white.withOpacity(0.3),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  foodModel[index].name,
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 20,
                                      //min(max(boxHeight * 0.032, 14), 30),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "29 Jun",
                                  style: GoogleFonts.lato(
                                      fontSize: 15,
                                      //min(max(boxHeight * 0.022, 12), 24),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          width: size.width * 0.55,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Spicy Maguro ",
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 32,
                                  //min(max(boxHeight * 0.06, 18), 35),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: size.width * 0.10),
                            const Icon(
                              Icons.favorite,
                              size: 30,
                              color: Colors.black,
                            )
                          ],
                        ),
                        Text(
                          "Rich Nutrition",
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 25,
                              //min(max(boxHeight * 0.045, 16), 25),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.15),
                            //     offset: const Offset(0, 10),
                            //     blurRadius: 10,
                            //     spreadRadius: 3,
                            //   ),
                            // ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.add_circle_rounded, size: 18
                                  // boxHeight * 0.03,
                                  ),
                              const SizedBox(width: 7),
                              Text(
                                "Add to bag",
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    // min(max(boxHeight * 0.01, 14), 24),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
                Positioned(
                    bottom: size.height * 0.2 + slideY,
                    left: (-40) + slideX,
                    child: Hero(
                        tag: foodModel[index].image,
                        child: SizedBox(
                          width: boxHeight * 0.5,
                          child: Transform.rotate(
                            angle: currentAngle,
                            child: Image.asset(
                                key: ValueKey(foodModel[index].image),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                                height: boxHeight * 0.4,
                                foodModel[index].image),
                          ),
                        ))),
              ],
            );
          }),
    );
  }
}

class Helper {
  static double degreeToRadian(double degree) {
    return degree * pi / 180;
  }
}
