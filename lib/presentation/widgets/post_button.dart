import 'package:alien_mates/presentation/template/base/template.dart';

class PostButton extends StatelessWidget {
  Widget leftChild;
  Widget? rightChild;
  //if only one child needed, then pass leftChild only;
  PostButton({required this.leftChild, this.rightChild});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 25.h,
              width: double.infinity,
              alignment: Alignment.center,
              child: _buildChild(context),
              decoration: BoxDecoration(
                color: ThemeColors.yellow.withOpacity(1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
              )),
        ),
      ],
    );
  }

  Widget _buildChild(context) {
    if (rightChild != null) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 2.w - 30,
                child: leftChild),
            Container(
                height: 25.h,
                width: 2.w,
                decoration: BoxDecoration(
                  color: ThemeColors.bgDark,
                  borderRadius: BorderRadius.circular(10000),
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width / 2.w - 30,
                child: rightChild!),
          ]);
    } else {
      return leftChild;
    }
  }
}
