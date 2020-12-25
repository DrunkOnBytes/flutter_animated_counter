import 'dart:math';

import 'package:flutter/material.dart';

import 'package:animated_counter/animated_counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Demos(),
    );
  }
}

class Demos extends StatefulWidget {
  @override
  _DemosState createState() => _DemosState();
}

class _DemosState extends State<Demos> with TickerProviderStateMixin {
  TabController _controller;

  BlocksCounter block = BlocksCounter(
      initialCounter: 0, color: Colors.red, blend: BlendMode.lighten);
  DisksCounter disk = DisksCounter(initialCounter: 0, color: Colors.blue);
  WaveCounter wave = WaveCounter(initialCounter: 0, color: Colors.orange);
  CircleWaveCounter circle;
  RotatingBubblesCounter bub = RotatingBubblesCounter(
      initialCounter: 0,
      initialColors: [Colors.red, Colors.green, Colors.blue],
      blend: BlendMode.lighten);
  RotatingPlanetsCounter plan = RotatingPlanetsCounter(
      initialCounter: 0,
      initialColors: [Colors.red, Colors.green, Colors.blue],
      blend: BlendMode.lighten);
  CreatureCounter cre;
  ImageBubbleCounter imgbub =
      ImageBubbleCounter(initialCounter: 0, image: 'assets/dash.jpg');
  PortraitCounter por =
      PortraitCounter(initialCounter: 0, image: 'assets/mattis.jpeg');
  ParticlesCounter part;
  VolcanoCounter vol = VolcanoCounter(initialCounter: 0, enableSky: true);
  PixelCounter pix = PixelCounter(initialCounter: 0, color: Colors.cyan);

  List<String> getAssetName() {
    List<String> names = List();
    for (int i = 1; i < 47; i++) {
      final n = i < 10 ? '0$i' : '$i';
      names.add('assets/people/people$n.jpg');
    }
    return names;
  }

  @override
  void initState() {
    _controller = TabController(length: 12, vsync: this);

    circle = CircleWaveCounter(
        vsync: this,
        initialCounter: 0,
        initialColors: [Colors.red, Colors.green, Colors.blue],
        blend: BlendMode.lighten);
    cre = CreatureCounter(
        vsync: this,
        initialCounter: 0,
        initialColors: [Colors.red, Colors.green, Colors.blue]);
    part = ParticlesCounter(initialCounter: 0, images: getAssetName());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
            'Counter Demos: Press [+] to increment counter and [-] to decrement counter.'),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: [
            Tab(
              text: 'Block',
            ),
            Tab(
              text: 'Disk',
            ),
            Tab(
              text: 'Wave',
            ),
            Tab(
              text: 'CircleWave',
            ),
            Tab(
              text: 'RotatingBubbles',
            ),
            Tab(
              text: 'RotatingPlanets',
            ),
            Tab(
              text: 'Creature',
            ),
            Tab(
              text: 'ImageBubble',
            ),
            Tab(
              text: 'Portrait',
            ),
            Tab(
              text: 'Particles',
            ),
            Tab(
              text: 'Volcano',
            ),
            Tab(
              text: 'Pixel',
            )
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          TabBarView(
            controller: _controller,
            children: [
              block.build(context),
              disk.build(context),
              wave.build(context),
              circle.build(context),
              bub.build(context),
              plan.build(context),
              cre.build(context),
              imgbub.build(context),
              por.build(context),
              part.build(context),
              vol.build(context),
              pix.build(context),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  child: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      block.decrementCounter();
                      disk.decrementCounter();
                      wave.decrementCounter();
                      circle.decrementCounter();
                      bub.decrementCounter();
                      plan.decrementCounter();
                      cre.decrementCounter();
                      imgbub.decrementCounter();
                      por.decrementCounter();
                      part.decrementCounter();
                      vol.decrementCounter();
                      pix.decrementCounter();
                    });
                  },
                ),
                SizedBox(
                  width: 50,
                ),
                FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      block.incrementCounter();
                      disk.incrementCounter();
                      wave.incrementCounter();
                      circle.incrementCounter();
                      bub.incrementCounter();
                      plan.incrementCounter();
                      cre.incrementCounter();
                      imgbub.incrementCounter();
                      por.incrementCounter();
                      part.incrementCounter();
                      vol.incrementCounter();
                      pix.incrementCounter();
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
