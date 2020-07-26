import 'package:flutter/material.dart';

class HomePageSecondSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Container(
        height: 213.0,
        child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          SafeArea(
            top: true,
            bottom: true,
            child: Container(
              width: 230.0,

              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 180.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              'assets/img/grthre.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // description and share/explore buttons
              // share, explore buttons
            ),
          ),
          SafeArea(
            top: true,
            bottom: true,
            child: Container(
              width: 270.0,

              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 180.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              'assets/img/grtwo.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // description and share/explore buttons
              // share, explore buttons
            ),
          ),
          SafeArea(
            top: true,
            bottom: true,
            child: Container(
              width: 270.0,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 180.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              'assets/img/back.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // description and share/explore buttons
              // share, explore buttons
            ),
          ),
        ]),
      ),
    );
  }
}
