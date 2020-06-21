import 'package:flutter/material.dart';

class AnimatedChatBar extends StatefulWidget {
  @override
  _AnimatedChatBarState createState() => _AnimatedChatBarState();
}

class _AnimatedChatBarState extends State<AnimatedChatBar>
    with TickerProviderStateMixin {
  bool animationToggle = true;

  // _slideAnimation1 controlls the textfield to move to upper offset
  // and back to previous position when needed using _controller2
  // and _slideAnimation2 does the same thing for the row of icons
  Animation<Offset> _slideAnimation1, _slideAnimation2;

  // _opacityAnimation fades its child using _controller2 when they are pushed out of the box
  Animation<double> _opacityAnimation1, _opacityAnimation2;

  // First controller is for controlling the main container animation,
  //  the container which contains the animated icon and textfield/ icons.
  // Second controller controlls the animated icon and slide transition and fade transitions.
  AnimationController controller1, _controller2;

  @override
  void initState() {
    super.initState();
    controller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller1.reverse();
            }
          });
    _controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {});
          });
    _slideAnimation1 = Tween(begin: Offset(0.0, 0.0), end: Offset(0.0, -1.5))
        .animate(_controller2);
    _slideAnimation2 = Tween(begin: Offset(0.0, 1.5), end: Offset(0.0, 0.0))
        .animate(_controller2);
    _opacityAnimation1 = Tween(begin: 1.0, end: 0.0).animate(_controller2);
    _opacityAnimation2 = Tween(begin: 0.0, end: 1.0).animate(_controller2);
  }

  @override
  void dispose() {
    controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        color: Colors.deepPurpleAccent[100],
        child: RotationTransition(
          alignment: Alignment.centerLeft,
          turns: Tween(begin: 0.0, end: animationToggle ? 0.02 : -0.02)
              .animate(controller1),
          child: Container(
            height: 62.0,
            width: 250.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.deepPurple),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      // changing the value of boolean each time the icon is tapped
                      animationToggle = !animationToggle;
                    });
                    controller1.forward();
                    animationToggle
                        ? _controller2.reverse()
                        : _controller2.forward();
                  },
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[50]),
                    child: Center(
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _controller2,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      FadeTransition(
                        opacity: _opacityAnimation1,
                        child: SlideTransition(
                          position: _slideAnimation1,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey[50]),
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            alignment: Alignment.centerLeft,

                            // Here I simply use Text widget, you can use textfield for getting textfield
                            // with inputborder as none and with a hinttext and hintstyle
                            // as defined below
                            child: Text(
                              "Type a message...",
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.deepPurpleAccent[200],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeTransition(
                        opacity: _opacityAnimation2,
                        child: SlideTransition(
                          position: _slideAnimation2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.grey[50],
                                child: IconButton(
                                  icon: Icon(
                                    Icons.photo_library,
                                    color: Colors.deepPurple,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.grey[50],
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.deepPurple,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.grey[50],
                                child: IconButton(
                                  icon: Icon(
                                    Icons.videocam,
                                    color: Colors.deepPurple,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
