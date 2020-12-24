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

class _DemosState extends State<Demos> with TickerProviderStateMixin{
  BlocksCounter block = BlocksCounter(initialCounter: 0);
  DisksCounter disk = DisksCounter(initialCounter: 0);
  WaveCounter wave = WaveCounter(initialCounter: 0);
  CircleWaveCounter circle;
  RotatingBubblesCounter bub = RotatingBubblesCounter(initialCounter: 0, initialColors: [Colors.red, Colors.green, Colors.blue]);
  RotatingPlanetsCounter plan = RotatingPlanetsCounter(initialCounter: 0, initialColors: [Colors.red, Colors.green, Colors.blue]);
  CreatureCounter cre;
  ImageBubbleCounter imgbub = ImageBubbleCounter(initialCounter: 0, image: 'assets/dash.jpg');
  PortraitCounter por = PortraitCounter(initialCounter: 5, image: 'assets/mattis.jpeg');
  ParticlesCounter part;
  VolcanoCounter vol = VolcanoCounter(initialCounter: 0, enableSky: true);

  List<String> getAssetName() {
    List<String> names = List();
    for(int i = 1 ; i<47; i++){
      final n = i < 10 ? '0$i' : '$i';
      names.add('assets/people/people$n.jpg');
    }
    return names;
  }

  @override
  void initState() {
    circle = CircleWaveCounter(vs: this, initialCounter: 0, initialColors: [Colors.red, Colors.green, Colors.blue]);
    cre = CreatureCounter(vs: this, initialCounter: 0, initialColors: [Colors.red, Colors.green, Colors.blue]);
    part = ParticlesCounter(initialCounter: 0, images: getAssetName());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Apps'),
      ),
      body: PageView(
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
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
          });
        },
      ),
    );
  }
}