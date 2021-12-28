import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImageOrTextImageWidget extends StatelessWidget {
  String? imageUrl;
  String? title;
  String? description;
  int maxLines;
  CachedImageOrTextImageWidget({
    this.description,
    this.title,
    this.imageUrl,
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(10.w),
        child: _buildSupportTextsWidget(),
      );
    }
  }

  Widget _buildSupportTextsWidget() {
    List<Widget> list = [];
    if (title != null) {
      list.add(Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: SizedText(
          textAlign: TextAlign.left,
          text: title,
          textStyle: latoM20.copyWith(color: ThemeColors.fontDark),
        ),
      ));
    }
    if (title != null) {
      list.add(Divider(thickness: 1.w, color: ThemeColors.borderDark));
    }
    list.add(SizedText(
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      maxLines: maxLines,
      text: description,
      textStyle: latoM16.copyWith(color: ThemeColors.fontDark),
    ));
    return SpacedColumn(
        verticalSpace: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list);
  }
}
