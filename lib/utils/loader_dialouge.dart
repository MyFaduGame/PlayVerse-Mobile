//Third Party Imports
import 'dart:math';

//Local Imports
import 'package:flutter/widgets.dart';
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

List<String> randomDescriptionForTournaments = [
  'Register Now Limited Slots Available.',
  'Secure Your Spot! Availability is Running Out!',
  'Hurry! Join the Exclusive List Before It\'s Full!',
  'Act Fast! Limited Opportunities to Sign Up!',
  'Don\'t Miss Out! Limited Openings Remaining!',
  'Grab Your Place! Slots Are Filling Quickly!',
  'Enroll Today! Space is Limited!',
  'Immediate Registration Required – Only a Few Spots Left!',
  'Be Quick to Book Your Slot – They\'re Going Fast!',
  'Sign Up Now – Space is at a Premium!',
];

String getRandomDescriptionForTournament() {
  Random random = Random();
  int index = random.nextInt(randomDescriptionForTournaments.length);
  return randomDescription[index];
}

int getRandomReadMinutes() {
  Random random = Random();
  int index = random.nextInt(10);
  return index;
}

List<Color> randomColorList = [
  const Color(0xFF3DB79A),
  const Color(0xFF851BC3),
  const Color(0xFF953B08),
  const Color(0xFF690E0E),
];

Color getRandomColor() {
  Random random = Random();
  int index = random.nextInt(randomColorList.length);
  return randomColorList[index];
}
