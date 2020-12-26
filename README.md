# animated_counter
-------------------------------------------------------------

A collection of animated counters sourced during the FlutterCounterChallenge2020.

Block                      | Circle Wave               |        Creatures
:-------------------------:|:-------------------------:|:-------------------------:
![Block](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/blocks.gif)    | ![Circle Wave](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/circle_wave.gif) |  ![Creatures](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/creatures.gif)

Image Bubble               |Particles                  |        Portrait
:-------------------------:|:-------------------------:|:-------------------------:
![Image Bubble](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/image_bubble.gif)   |![Particles](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/particles.gif)      |  ![Portrait](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/portrait.gif)

Rotating Bubbles           |        Rotating Planets   |        Volcano
:-------------------------:|:-------------------------:|:-------------------------:
![Rotating Bubbles](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/rotating_bubbles.gif) |  ![Rotating Planets](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/rotating_planets.gif)|  ![Volcano](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/volcano.gif)

Wave                       |        Pixel             |        Disks
:-------------------------:|:-------------------------:|:-------------------------:
![Wave](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/wave.gif)         |  ![Pixel](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/pixel.gif)         |  ![Disks](https://raw.githubusercontent.com/RyuuKenshi/flutter_animated_counter/main/ss/disks.gif)


## Features

* Beautiful Smooth Animations
* Ability to increment, decrement and get current counter value.
* One stop destination for FlutterCounterChallenge2020 widgets.
* Completely open source.

## Supported platforms

* Flutter Android
* Flutter iOS
* Flutter web
* Flutter desktop

## Live preview

http://ryuukenshi.github.io/animated_counter

Note: This page is built with flutter-web, hence the animations may not be smooth. For a better user experience, please run the example app on a mobile device.

## Installation

Add `animated_counter: 0.0.5` to your `pubspec.yaml` dependencies. And import it:

```dart
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
```

## How to use
-----------------------------------------------

First create the object of the Animated Counter you wish to use. Then use its `build()` method to build it. Finally use the `incrementCounter()`, `decrementCounter()` and `getCounter()` methods to control the widget animations.

### Create the object of the animated counter you like

```dart
  BlocksCounter block = BlocksCounter(initialCounter: 0);
  DisksCounter disk = DisksCounter(initialCounter: 0);
  WaveCounter wave = WaveCounter(initialCounter: 0);
  CircleWaveCounter circle;
  RotatingBubblesCounter bub = RotatingBubblesCounter(initialCounter: 0, initialColors: [Colors.red, Colors.green, Colors.blue]);
  RotatingPlanetsCounter plan = RotatingPlanetsCounter(initialCounter: 0, initialColors: [Colors.red, Colors.green, Colors.blue]);
  CreatureCounter cre;
  ImageBubbleCounter imgbub = ImageBubbleCounter(initialCounter: 0, image: 'assets/dash.jpg');
  PortraitCounter por = PortraitCounter(initialCounter: 0, image: 'assets/mattis.jpeg');
  ParticlesCounter part;
  VolcanoCounter vol = VolcanoCounter(initialCounter: 0, enableSky: true);
  PixelCounter pix = PixelCounter(initialCounter: 0);

  @override
    void initState() {
      circle = CircleWaveCounter(vsync: this, initialCounter: 0, initialColors: [Colors.red, Colors.green, Colors.blue]);
      cre = CreatureCounter(vsync: this, initialCounter: 0, initialColors: [Colors.red, Colors.green, Colors.blue]);
      part = ParticlesCounter(initialCounter: 0, images: ['image1.jpg', 'image2.jpg', 'image3.jpg', 'image4.jpg', 'image5.jpg']);
      super.initState();
    }
```
`CircleWaveCounter()` and `CreatureCounter()` require a vsync hence the parent class needs to extend `TickerProviderStateMixin` to use these counters.

### Use it in widget tree using `build()` method. Control it using the `incrementCounter()`, `decrementCounter()` and `getCounter()` methods.

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
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
          pix.build(context),
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
            pix.incrementCounter();
          });
        },
      ),
    );
  }
```

## License
--------------------------------------------------------------

Apache 2.0