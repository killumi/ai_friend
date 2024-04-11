import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter/material.dart';

const cellRed = Color(0xffc73232);
const cellMustard = Color(0xffd7aa22);
const cellGrey = Color(0xffcfd4e0);
const cellBlue = Color(0xff1553be);
const background = Color(0xff242830);

class TestImgScreen extends StatefulWidget {
  const TestImgScreen({super.key});

  @override
  State<TestImgScreen> createState() => _TestImgScreenState();
}

class _TestImgScreenState extends State<TestImgScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 350,
          color: background,
          child: AspectRatio(
            aspectRatio: 9 / 14,
            child: LayoutGrid(
              columnGap: 1,
              rowGap: 1,
              areas: '''
           R m
           R y
                  ''',
              columnSizes: [
                5.0.fr,
                1.0.fr,
                // 1.0.fr,
                // 1.0.fr,
                // 3.5.fr,
                // 1.3.fr,
                // 1.3.fr,
                // 1.3.fr,
              ],
              rowSizes: [
                // 1.0.fr,
                1.0.fr,
                1.0.fr,
                // 1.0.fr,
                // 3.0.fr,
                // 1.0.fr,
                // 0.3.fr,
                // 1.5.fr,
                // 1.2.fr,
              ],
              children: [
                // Column 1
                gridArea('m').containing(Container(color: cellBlue)),
                gridArea('y').containing(Container(color: cellMustard)),
                // Column 2
                gridArea('R').containing(Container(color: cellRed)),
                // gridArea('R').containing(Container(color: cellRed)),
                // Column 3
                // gridArea('B').containing(Container(color: cellBlue)),
                // gridArea('Y').containing(Container(color: cellMustard)),
                // gridArea('g').containing(Container(color: cellGrey)),
                // Column 4
                // gridArea('b').containing(Container(color: cellBlue)),
                // Column 5
                // gridArea('yy').containing(Container(color: cellMustard)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
