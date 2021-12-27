import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget createPopupContent(String url) => ClipRRect(
    borderRadius: BorderRadius.circular(16.r),
    child: CachedNetworkImage(imageUrl: url, height: 400.h));

Widget createPopupContentForDesc(String desc) => Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    width: 300.w,
    height: 400.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: ThemeColors.borderDark,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: SizedText(
        textAlign: TextAlign.left,
        text: desc,
        textStyle: latoM16.copyWith(color: ThemeColors.fontWhite)));

// if(desc!= null)
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
