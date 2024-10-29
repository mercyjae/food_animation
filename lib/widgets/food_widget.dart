import 'package:animations_pratice/model/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class FoodWidget extends StatelessWidget {
  final Animation<double> growAnimation;
  final Animation<double> shrinkAnimation;
  final Animation<double> progressAnimation;

  final int? previousIndex;
  final int index;
  final int currentIndex;
  final double visiblePortion;
  const FoodWidget({
    super.key,
    required this.index,
    required this.growAnimation,
    required this.shrinkAnimation,
    required this.progressAnimation,
    this.previousIndex,
    required this.currentIndex,
    required this.visiblePortion,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    double maxHeight = size.height * 0.7;
    double minHeight = size.height * 0.43;
    double boxWidth = size.width * 0.8;
    return AnimatedBuilder(
        animation: Listenable.merge([growAnimation, shrinkAnimation]),
        builder: (BuildContext context, Widget? child) {
          final progress = progressAnimation.value * visiblePortion;
          final scale = 0.7 + (0.5 * progress);

          final baseAngle = 30 * pi / 180;

          final targetAngle = baseAngle - 60 * pi / 180;

          double currentAngle;
          if (currentIndex == index) {
            currentAngle =
                baseAngle + (targetAngle - baseAngle) * growAnimation.value;
          } else if (previousIndex == index) {
            currentAngle =
                targetAngle + (baseAngle - targetAngle) * shrinkAnimation.value;
          } else {
            currentAngle = baseAngle + (-48 * pi / 180 * visiblePortion);
          }

          double boxHeight = minHeight;

          if (currentIndex == index) {
            boxHeight =
                minHeight + ((maxHeight - minHeight) * growAnimation.value);
          } else if (previousIndex == index) {
            boxHeight = minHeight +
                ((maxHeight - minHeight) * (1 - shrinkAnimation.value));
          }

          return Stack(
            children: [
              Container(
                height: boxHeight,
                width: boxWidth,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: foodModel[index].color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: Image.asset(
                              foodModel[index].image,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodModel[index].name,
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "29 Jun",
                                style: GoogleFonts.lato(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 1,
                        width: size.width * 0.55,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Spicy Maguro ",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: size.width * 0.13),
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
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.add_circle_rounded, size: 18),
                            const SizedBox(width: 7),
                            Text(
                              "Add to bag",
                              style: GoogleFonts.lato(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              Positioned(
                  bottom: size.width * 0.15,
                  left: size.width * 0.1,
                  child: Hero(
                      tag: foodModel[index].image,
                      child: SizedBox(
                        width: boxWidth * 0.9,
                        child: Transform.rotate(
                          angle: currentAngle,
                          child: Image.asset(
                            foodModel[index].image,
                            key: ValueKey(foodModel[index].image),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            height: boxHeight * 0.4,
                          ),
                        ),
                      ))),
            ],
          );
        });
  }
}
