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

List<String> randomDescription = [
  'Join the ultimate battle royale showdown! Compete for glory and rewards in this epic gaming tournament of champions. Are you ready?',
  "Gear up for intense clashes in our multiplayer gaming extravaganza! Test your skills against the best and emerge victorious. Register now!",
  "Embark on an adventure like never before! Dive into the world of gaming tournaments and prove your mettle against fierce opponents. Claim victory today!",
  "Experience adrenaline-pumping action in our esports showdown! Show off your gaming prowess and dominate the competition. Don't miss out on the excitement!",
  "Calling all gamers! Step into the arena and face off against formidable rivals. Compete for fame, fortune, and glory in our thrilling gaming tournament!",
  "Get ready to battle it out in the ultimate gaming showdown! Challenge your skills, conquer opponents, and emerge as the champion of champions!",
  "Unleash your gaming skills in our electrifying tournament! Compete against players from around the world and stake your claim to gaming greatness.",
  "Prepare for an epic clash of titans in our esports championship! Fight for supremacy, conquer challenges, and emerge as the undisputed champion!",
  "Enter the realm of gaming glory and prove your worth in our competitive tournament! Show off your skills, rise to the challenge, and dominate the battlefield!",
  "Join us for a gaming spectacle like no other! Compete against the best, forge new alliances, and emerge victorious in our epic gaming tournament!",
];

String getRandomDescription() {
  Random random = Random();
  int index = random.nextInt(randomDescription.length);
  return randomDescription[index];
}
