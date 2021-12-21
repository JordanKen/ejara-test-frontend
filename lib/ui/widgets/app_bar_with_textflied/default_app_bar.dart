import 'package:flutter/cupertino.dart';
import 'package:money/constants/colors.dart';

import 'icon_button.dart';
import 'my_painter.dart';
import 'search_bar.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget>? leading;

  final Widget? action;
  final bool? showSearch;
  DefaultAppBar({required this.leading,required this.action,required this.showSearch});

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  _DefaultAppBarState createState() => _DefaultAppBarState(this.leading!, this.action);
}

class _DefaultAppBarState extends State<DefaultAppBar> with SingleTickerProviderStateMixin {

  final List<Widget> leading;
  final Widget? action;

  _DefaultAppBarState(this.leading, this.action);

  double? rippleStartX, rippleStartY;
  AnimationController? _controller;
  Animation? _animation;
  bool isInSearchMode = false;


  @override
  initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    _controller!.addStatusListener(animationStatusListener);
  }

  animationStatusListener(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {
      setState(() {
       isInSearchMode = true; 
      });
    }
  }

  void onSearchTapUp(TapUpDetails details) {
    setState(() {
      rippleStartX = details.globalPosition.dx;
      rippleStartY = details.globalPosition.dy;
    });

    print("pointer location $rippleStartX, $rippleStartY");
    _controller!.forward();
  }

  cancelSearch() {
    setState(() {
      isInSearchMode = false;
    });

    onSearchQueryChange('');
    _controller!.reverse();
  }

  onSearchQueryChange(String query) {
    print('search $query');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 25),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops:[0.1,0.7],
                  colors: [
                    AppColors.primarycolor,
                    AppColors.primarycolor,
                  ],
                )
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0),
                    child:Row(mainAxisSize: MainAxisSize.min, children: leading,),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.showSearch!?GestureDetector(
                        child: CustomIconButton(
                          splashRadius: 20,
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        onTapUp: onSearchTapUp,
                      ):Container(),
                      action!,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animation!,
          builder: (context, child) {
            return CustomPaint(
              painter: MyPainter(
                containerHeight: widget.preferredSize.height,
                center: Offset(rippleStartX ?? 0, rippleStartY ?? 0),
                radius: _animation!.value * screenWidth,
                context: context,
              ),
            );
          },
        ),

        isInSearchMode ? (
          SearchBar(
            onCancelSearch: cancelSearch,
            onSearchQueryChanged: onSearchQueryChange,
          )
        ) : (
          Container()
        )
      ]
    );
  }
}