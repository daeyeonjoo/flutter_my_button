import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final Widget child;

  MyButton({required this.child});

  @override
  State<StatefulWidget> createState() {
    return _MyButtonState();
  }
}

class _MyButtonState extends State<MyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  var _opacityTween = Tween<double>(begin: 1.0, end: 0.5);
  var _isButtonDown = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, value: 0.0, duration: Duration(milliseconds: 10));
    _animation = _controller
        .drive(CurveTween(curve: Curves.easeInBack))
        .drive(_opacityTween);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: onTapDown,
        onTapUp: onTapUp,
        onTap: onTap,
        onTapCancel: onTapCancel,
        child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 135, minHeight: 50),
            child: FadeTransition(
                opacity: _animation,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Colors.amber),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 64.0),
                        child: Align(
                            alignment: Alignment.center,
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: widget.child))))));
  }

  void _animate() {
    if (_controller.isAnimating) return;

    final wasButtonDown = _isButtonDown;
    final TickerFuture future =
        _isButtonDown ? _controller.animateTo(1.0) : _controller.animateTo(0.0, duration: Duration(milliseconds: 200));

    future.then<void>((void value) {
      if (wasButtonDown != _isButtonDown) _animate();
    });
  }

  void onTap() {

  }

  void onTapDown(TapDownDetails event) {
    _isButtonDown = true;
    _animate();
  }

  void onTapUp(TapUpDetails event) {
    _isButtonDown = false;
    _animate();
  }

  void onTapCancel() {
    _isButtonDown = false;
    _animate();
  }
}
