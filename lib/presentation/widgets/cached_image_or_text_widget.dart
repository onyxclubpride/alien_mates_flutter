import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImageOrTextImageWidget extends StatelessWidget {
  String? imageUrl;
  String? title;
  String? description;
  CachedImageOrTextImageWidget({
    this.description,
    this.title,
    this.imageUrl,
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
        padding: EdgeInsets.all(14.w),
        child: _buildSupportTextsWidget(),
      );
    }
  }

  Widget _buildSupportTextsWidget() {
    List<Widget> list = [];
    list.add(Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: SizedText(
        textAlign: TextAlign.left,
        text: title,
        textStyle: latoM20.copyWith(color: ThemeColors.fontDark),
      ),
    ));
    list.add(Divider(thickness: 1.w, color: ThemeColors.borderDark));
    list.add(SizedText(
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      maxLines: 5,
      text: description,
      textStyle: latoM16.copyWith(color: ThemeColors.fontDark),
    ));
    return SpacedColumn(
        verticalSpace: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list);
  }
}
