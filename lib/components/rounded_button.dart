import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum LoadingState { idle, loading, success, error }

class RoundedButton extends StatefulWidget {
  final String text;
  final RoundedButtonController controller;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final bool animateOnTap;

  RoundedButton(
      {@required this.text,
      this.onPressed,
      this.controller,
      this.height,
      this.width,
      this.animateOnTap = true});

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton>
    with TickerProviderStateMixin {
  AnimationController _buttonController;
  AnimationController _checkButtonController;

  Animation _squeezeAnimation;
  Animation _bounceAnimation;
  Animation _squeezeAnimationCircular;

  final _state = BehaviorSubject<LoadingState>.seeded(LoadingState.idle);

  @override
  void initState() {
    super.initState();

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);

    _checkButtonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    _bounceAnimation = Tween<double>(begin: 0, end: widget.height).animate(
        new CurvedAnimation(
            parent: _checkButtonController, curve: Curves.elasticOut));
    _bounceAnimation.addListener(() {
      setState(() {});
    });

    _squeezeAnimation = Tween<double>(begin: widget.width, end: widget.height)
        .animate(new CurvedAnimation(
            parent: _buttonController, curve: Curves.easeInOutCirc));
    _squeezeAnimation.addListener(() {
      setState(() {});
    });

    _squeezeAnimationCircular =
        Tween<double>(begin: widget.height * 0.15, end: widget.height * 0.6)
            .animate(new CurvedAnimation(
                parent: _buttonController, curve: Curves.easeInOutCirc));
    _squeezeAnimationCircular.addListener(() {
      setState(() {});
    });

    _squeezeAnimationCircular.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        widget.onPressed();
      }
    });

    widget.controller?._addListeners(_start, _stop, _success, _error, _reset);
  }

  @override
  void dispose() {
    _buttonController.dispose();
    _checkButtonController.dispose();
    _state.close();
    super.dispose();
  }

  _btnPressed() async {
    if (widget.animateOnTap) {
      _start();
    } else {
      widget.onPressed();
    }
  }

  _start() {
    _state.sink.add(LoadingState.loading);
    _buttonController.forward();
  }

  _stop() {
    _state.sink.add(LoadingState.idle);
    _buttonController.reverse();
  }

  _success() {
    _state.sink.add(LoadingState.success);
    _checkButtonController.forward();
  }

  _error() {
    _state.sink.add(LoadingState.error);
    _checkButtonController.forward();
  }

  _reset() {
    _state.sink.add(LoadingState.idle);
    _buttonController.reverse();
    _checkButtonController.reset();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    var _check = Container(
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF17ead9),
            Colors.blue,
          ]),
          borderRadius:
              new BorderRadius.all(Radius.circular(_bounceAnimation.value / 2)),
        ),
        width: _bounceAnimation.value,
        height: _bounceAnimation.value,
        child: _bounceAnimation.value > 20
            ? Icon(
                Icons.check,
                color: Colors.white,
              )
            : null);

    var _cross = Container(
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
          color: Colors.red,
          borderRadius:
              new BorderRadius.all(Radius.circular(_bounceAnimation.value / 2)),
        ),
        width: _bounceAnimation.value,
        height: _bounceAnimation.value,
        child: _bounceAnimation.value > 20
            ? Icon(
                Icons.close,
                color: Colors.white,
              )
            : null);

    var _loader = SizedBox(
        height: widget.height - 25,
        width: widget.height - 25,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2));

    var childStream = StreamBuilder(
      stream: _state,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: snapshot.data == LoadingState.loading
                ? _loader
                : Text(
                    widget.text,
                    style: textTheme.headline1.copyWith(
                        letterSpacing: 1.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 19.6),
                  ));
      },
    );

    var _btn = Container(
      width: _squeezeAnimation.value,
      height: widget.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF17ead9),
            Colors.blue,
          ]),
          borderRadius: BorderRadius.circular(_squeezeAnimationCircular.value),
          boxShadow: [
            BoxShadow(
                color: Color(0xFF6078ea).withOpacity(.3),
                offset: Offset(0.0, screenHeight * 0.01),
                blurRadius: screenHeight * 0.01)
          ]),
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: childStream,
        ),
      ),
    );

    return InkWell(
        onTap: widget.onPressed == null ? null : _btnPressed,
        child: Container(
          height: widget.height,
          child: Center(
              child: _state.value == LoadingState.error
                  ? _cross
                  : _state.value == LoadingState.success ? _check : _btn),
        ));
  }
}

class RoundedButtonController {
  VoidCallback _startListener;
  VoidCallback _stopListener;
  VoidCallback _successListener;
  VoidCallback _errorListener;
  VoidCallback _resetListener;

  _addListeners(
      VoidCallback startListener,
      VoidCallback stopListener,
      VoidCallback successListener,
      VoidCallback errorListener,
      VoidCallback resetListener) {
    this._startListener = startListener;
    this._stopListener = stopListener;
    this._successListener = successListener;
    this._errorListener = errorListener;
    this._resetListener = resetListener;
  }

  start() {
    _startListener();
  }

  stop() {
    _stopListener();
  }

  success() {
    _successListener();
  }

  error() {
    _errorListener();
  }

  reset() {
    _resetListener();
  }
}
