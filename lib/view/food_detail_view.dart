import 'package:animations_pratice/model/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FoodDetailView extends StatelessWidget {
  final String imageName;
  const FoodDetailView({super.key, required this.imageName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color(0xff2f343e),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Positioned(
              top: -(size.height * 0.2),
              child: Hero(
                  tag: imageName,
                  child: SizedBox(
                    width: size.width,
                    child: Image.asset(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        height: size.width,
                        imageName),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CATEGORY",
                    style: GoogleFonts.lato(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                    child: Row(
                      children: [
                        ...categories.map((e) {
                          int index = categories.indexOf(e);
                          return Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(50),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              categories[index]["image"])),
                                      color: categories[index]["color"],
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      categories[index]["name"],
                                      style:
                                          GoogleFonts.lato(color: Colors.white),
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "\$${categories[index]["price"]}",
                                          style: GoogleFonts.lato(
                                              color: const Color(0xfffb5151),
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: "/kg",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey))
                                    ]))
                                  ],
                                ),
                              ],
                            ),
                          )
                              .animate()
                              .slideY(
                                begin: 5,
                                duration: Duration(
                                  milliseconds: 400 * (index + 1),
                                ),
                                curve: Curves.easeOut,
                              )
                              .fadeIn(
                                begin: 0.1,
                                delay: Duration(
                                  milliseconds: 200 * (index + 1),
                                ),
                              );
                        })
                      ],
                    ),
                  ),
                  Text(
                    "RECENT SEARCH",
                    style: GoogleFonts.lato(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: size.height * 0.25,
                    child: ListView.builder(
                        itemCount: recentSearch.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  width: size.width * 0.28,
                                  height: size.height * 0.16,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            recentSearch[index]["image"])),
                                    gradient: RadialGradient(
                                      center: Alignment.center,
                                      colors: [
                                        Color.lerp(recentSearch[index]["color"],
                                            Colors.white, 0.1)!,
                                        recentSearch[index]["color"],
                                        Color.lerp(recentSearch[index]["color"],
                                            Colors.black, 0.1)!,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  recentSearch[index]["name"],
                                  style: GoogleFonts.lato(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                              .animate()
                              .slideY(
                                begin: 5,
                                duration: Duration(
                                  milliseconds: 400 * (index + 1),
                                ),
                                curve: Curves.easeOut,
                              )
                              .fadeIn(
                                begin: 0.1,
                                delay: Duration(
                                  milliseconds: 200 * (index + 1),
                                ),
                              );
                        }),
                  ),
                  Text(
                    "TAG",
                    style: GoogleFonts.lato(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: [
                      const Icon(
                        Icons.add_circle_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ...tags.map((e) {
                        int index = tags.indexOf(e);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10, right: 10),
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 13,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: e["isSelected"] == false
                                  ? const Color(0xff444c59)
                                  : const Color(0xfffb5151)),
                          child: Text(
                            e["name"],
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                        )
                            .animate()
                            .slideY(
                              begin: 5,
                              duration: Duration(
                                milliseconds: 400 * (index + 1),
                              ),
                              curve: Curves.easeOut,
                            )
                            .fadeIn(
                              begin: 0.1,
                              delay: Duration(
                                milliseconds: 200 * (index + 1),
                              ),
                            );
                      })
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
