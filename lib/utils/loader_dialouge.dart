//Third Party Imports
import 'dart:math';

//Local Imports
import 'package:playverse/themes/app_images.dart';

List<String> imageList = [
  LoadingImages.loading0,
  LoadingImages.loading1,
  LoadingImages.loading2
];

String getRandomImage() {
  Random random = Random();
  int index = random.nextInt(
    imageList.length,
  );
  return imageList[index];
}

List<String> imageRandomList = [
  LoadingImages.loading1,
  LoadingImages.loading2,
  LoadingImages.loading3
];

String getRandomLoaderImage() {
  Random random = Random();
  int index = random.nextInt(
    imageRandomList.length,
  );
  return imageRandomList[index];
}

List<String> textList = [
  'Gamer',
  'Geek',
  'Ace',
  'Ninja',
  'Legend',
  'Hero',
  'Champ',
  'Wizard',
];

String getRandomText() {
    Random random = Random();
    int index = random.nextInt(textList.length);
    return textList[index];
  }
