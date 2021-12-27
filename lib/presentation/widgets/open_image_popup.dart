import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget createPopupContent(String url) => ClipRRect(
    borderRadius: BorderRadius.circular(16.r),
    child: CachedNetworkImage(imageUrl: url, height: 400.h));

class AnimatedDialog extends StatefulWidget {
  const AnimatedDialog({required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => AnimatedDialogState();
}

class AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? opacityAnimation;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.easeOutExpo);
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.6).animate(
        CurvedAnimation(parent: controller!, curve: Curves.easeOutExpo));

    controller!.addListener(() => setState(() {}));
    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(opacityAnimation!.value),
      child: Center(
        child: FadeTransition(
          opacity: scaleAnimation!,
          child: ScaleTransition(
            scale: scaleAnimation!,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
