import 'dart:ui';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scoop/model/model.dart';
import 'package:scoop/network/network.dart';
import 'package:sheet/sheet.dart';

class ScoopStream extends StatefulWidget {
  const ScoopStream({Key? key}) : super(key: key);

  @override
  State<ScoopStream> createState() => _ScoopStreamState();
}

class _ScoopStreamState extends State<ScoopStream> {

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: FutureBuilder(
          future: NetworkSystem().contentBuilder(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Expanded(child: Center(child: CupertinoActivityIndicator(color: Colors.white.withOpacity(0.7),))),
                ],
              );
            } else {
              print(snapshot.data);
              List<Article> articles = snapshot.data!;
              return PageView.builder(
                controller: _controller,
                padEnds: false,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                        child: Container(
                          // padding: EdgeInsets.only(top: 70, left: 10, right: 10),
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(snapshot.data![index].imgURL)
                            )
                          ),
                        ),
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        top: 70,
                        left: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              width: (MediaQuery.of(context).size.width) - 50,
                              height: (MediaQuery.of(context).size.width) - 50,
                              // height: (MediaQuery.of(context).size.width) - 50,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.data![index].imgURL),
                                    fit: BoxFit.cover
                                ),
                                shadows: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 30.0,
                                      spreadRadius: 5,
                                      offset: Offset(
                                          0,
                                          6
                                      )
                                  )
                                ],
                                color: Colors.red.withOpacity(0.75),
                                shape: SmoothRectangleBorder(
                                  borderRadius: SmoothBorderRadius(
                                    cornerRadius: 18,
                                    cornerSmoothing: 0.9,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                children: [
                                  Text(snapshot.data![index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        letterSpacing: -0.5,
                                        color: Colors.white
                                    ),
                                  ),
                                  SizedBox(height: 7.5),
                                  SizedBox(
                                    height: 20,
                                    // width: 100,
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data![index].source, style: TextStyle(color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w600),),
                                          Icon(FeatherIcons.chevronRight, size: 19, color: Colors.white.withOpacity(0.3),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(snapshot.data![index].content,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.4
                                    ),
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}