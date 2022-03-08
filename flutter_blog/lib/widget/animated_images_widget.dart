import 'package:flutter/cupertino.dart';

class AnimatedImages extends AnimatedWidget {
  final String cover;

  AnimatedImages(this.cover, {Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.biggest.width;
      final height = constraints.biggest.height;
      return Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Positioned(
                top: -animation.value / 2,
                left: -animation.value / 2,
                child: Image.network(
                  cover,
                  width: width + animation.value,
                  height: width + animation.value,
                  fit: BoxFit.cover,
                )),
            Container(
              width: width,
              height: height,
              color: Color(0xff000000).withAlpha(animation.value.toInt() * 2),
            )
          ],
        ),
      );
    });
  }
}
