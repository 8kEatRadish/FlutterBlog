import 'package:flutter/material.dart';
import 'package:flutter_blog/article/model/article_model.dart';
import 'package:flutter_blog/blog_route.dart';
import 'package:flutter_blog/widget/animated_images_widget.dart';
import 'package:get/get.dart';

class HomeWebArticleItemWidget extends StatefulWidget {
  final ArticleModel articleModel;

  const HomeWebArticleItemWidget(this.articleModel, {Key key})
      : super(key: key);

  @override
  _HomeWebArticleItemWidgetState createState() =>
      _HomeWebArticleItemWidgetState();
}

class _HomeWebArticleItemWidgetState extends State<HomeWebArticleItemWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _imageAnimation;
  Animation<Color> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _imageAnimation = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    _colorAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.white,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (hover) {
        if (hover) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      onTap: () {
        Get.toNamed(RouteConfig.articlePage);
      },
      child: Card(
        child: Stack(
          children: [
            AnimatedImages(
              widget.articleModel.cover,
              animation: _imageAnimation,
            ),
            Center(
              child: AnimatedBuilder(
                  animation: _imageAnimation,
                  builder: (context, _) {
                    return Text(
                      widget.articleModel.title,
                      style:
                          TextStyle(fontSize: 50, color: _colorAnimation.value),
                    );
                  }),
            )
          ],
        ),
        color: Colors.black45,
      ),
    );
  }
}
