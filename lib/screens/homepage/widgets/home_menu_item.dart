import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeMenuItem extends StatefulWidget {
  const HomeMenuItem({
    required this.title,
    required this.onTap,
    this.isWorkInProgress = false,
    super.key,
  });

  final String title;
  final void Function()? onTap;
  final bool isWorkInProgress;

  @override
  State<HomeMenuItem> createState() => _HomeMenuItemState();
}

class _HomeMenuItemState extends State<HomeMenuItem> {
  Color boxColor = Colors.white;
  Color textColor = Colors.black;
  bool isHighlighted = false;
  final int animationDuration = 300;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        if (value) {
          setState(() {
            boxColor = widget.isWorkInProgress
                ? Colors.red.withOpacity(0.8)
                : Colors.greenAccent.withOpacity(0.8);
            textColor = Colors.white;
            isHighlighted = true;
          });
        } else {
          setState(() {
            boxColor = Colors.white;
            textColor = Colors.black;
            isHighlighted = false;
          });
        }
      },
      child: SizedBox(
        width: 180,
        height: 180,
        child: AnimatedContainer(
          duration: Duration(milliseconds: animationDuration),
          curve: Curves.easeIn,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: const Color.fromARGB(255, 93, 91, 91)
                  .withOpacity(isHighlighted ? 0.4 : 0.6),
            ),
            borderRadius: BorderRadius.circular(24),
            color: boxColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.title}${widget.isWorkInProgress ? '\n(WIP)' : ''}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ).animate(target: isHighlighted ? 1 : 0).tint(
                    color: Colors.white,
                    duration: Duration(milliseconds: animationDuration + 100),
                    curve: Curves.easeIn,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
