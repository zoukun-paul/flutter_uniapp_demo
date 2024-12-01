
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/common/widget/divide.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_controller.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_style.dart';

class SubjectPage extends GetStyleView<SubjectStyle, SubjectController> {

  @override
  Widget proxyBuild(BuildContext context) {
    return Column(
      children: [
        style.header(),
        divider(size: 1, bgColor: const Color(0xffE5E5E5), horizontal: true),
        Expanded(
          child: StaggeredGrid.count(
            crossAxisCount: style.scheduleHeaderRow().length,
            children: [
              ...style.scheduleHeaderRow().map((e)=>StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: e,
              )),
              StaggeredGridTile.fit(
                  crossAxisCellCount: 8,
                  child: SizedBox(
                    height: style.bodyHeight(context),
                    child: SingleChildScrollView(
                      child: StaggeredGrid.count(
                        crossAxisCount: style.scheduleHeaderRow().length,
                        children: [
                          StaggeredGrid.count(
                            crossAxisCount: 1,
                            children: [...controller.subScheduleTimes.map((e)=>style.scheduleCell(1, e))],
                          ),
                          // StaggeredGrid.count(
                          //   crossAxisCount: 1,
                          //   children: [...controller.subScheduleTimes.map((e)=>style.scheduleCell(1, e))],
                          // ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        )
      ],
    );
  }

}


class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
