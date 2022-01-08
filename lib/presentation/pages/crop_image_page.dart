// import 'package:alien_mates/presentation/template/base/template.dart';
// import 'package:image_cropping/image_cropping.dart';
//
// class CropImagePage extends StatefulWidget {
//
//   const CropImagePage({Key? key}) : super(key: key);
//
//   @override
//   State<CropImagePage> createState() => _CropImagePageState();
// }
//
// class _CropImagePageState extends State<CropImagePage> {
//   @override
//   Widget build(BuildContext context) {
//     return ImageCropper.cropImage(
//       context,
//       imageBytes!,
//           () {
//         // showLoader();
//       },
//           () {
//         // hideLoader();
//       },
//           (data) {
//         setState(() {
//           // imageBytes = data;
//         });
//       },
//       selectedImageRatio: ImageRatio.RATIO_1_1,
//       visibleOtherAspectRatios: true,
//       squareBorderWidth: 2,
//       squareCircleColor: Colors.black,
//       defaultTextColor: Colors.orange,
//       selectedTextColor: Colors.black,
//       colorForWhiteSpace: Colors.grey,
//     );
//   }
// }
