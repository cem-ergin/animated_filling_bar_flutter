import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Filling Bar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

const height = 600.0;
const width = 300.0;
const columnLength = 4;
const rowLength = 6;
const backgroundColor = Color.fromRGBO(0, 83, 156, 1);
const blockColor = Color.fromRGBO(238, 164, 127, 1);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: backgroundColor,
            ),
            ...List.generate(
              columnLength * rowLength,
                  (index) => _PositionedContainer(index: index),
            ),
          ],
        ),
      ),
    );
  }
}

class _PositionedContainer extends StatelessWidget {
  const _PositionedContainer({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: height / rowLength * (index / columnLength).floor(),
      left: width / columnLength * (index % columnLength),
      child: _AnimatedBlock(
        index: index,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: backgroundColor,
              width: 1.0, // Border width
            ),
            color: blockColor,
          ),
          height: height / rowLength,
          width: width / columnLength,
        ),
      ),
    );
  }
}

class _AnimatedBlock extends StatefulWidget {
  const _AnimatedBlock({required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  State<_AnimatedBlock> createState() => _AnimatedBlockState();
}

class _AnimatedBlockState extends State<_AnimatedBlock> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: 100 * widget.index),
          () {
        animate = true;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: animate ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: widget.child,
    );
  }
}
