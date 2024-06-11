class ApiUrls {
  static String baseUrl = "http://api.myfadugame.com/v1/";
  // static String baseUrl = "http://192.168.0.113:8000/v1/";
}

class UserUrls {
  static String userLogin = 'user/login';
  static String userRegistration = 'user/register';
  static String userProfile = 'user/profile';
}

class GamesUrls {
  static String gamesList = 'games';
  static String deleteGames = 'games/';
  static String addGames = 'games/usergames';
  static String userGames = "games/usergames";
}

class FriendsUrl {
  static String recommandedFriends = 'user/recommanded_friends';
  static String ownFriends = 'user/list_friends';
  static String addFriends = "user/create_friend";
  static String friendRequests = "user/friends";
  static String sentRequests = "user/sent";
  static String acceptRequests = "user/friend_request";
}

class UserStatusUrl {
  static String userFriendsStatus = "user/friends_status";
  static String userOwnStatus = "user/own_status";
}

class AchievementsUrl {
  static String allAchievements = "achievements/";
  static String userAchievements = 'achievements/user';
  static String teamAchievements = 'achievements/team';
}

class NotificationsUrl {
  static String getNotifications = "notification";
  static String readNotifications = "notification/read";
  static String notificationDevices = "notification/device";
}

class ArticlesUrl {
  static String getArticles = "articles";
}

class TournamentsUrl {
  static String getTournamentsList = "tournaments";
  static String getTournamentDetail = "tournaments";
  static String soloTournamentRegistrtation = "tournaments/user";
  static String userTournaments = "tournaments/user";
  static String tournamentWinner = "tournaments/winner";
}

class GemsUrl {
  static String getGemsList = "user/gems";
  static String getUserGemsData = "user/gems_data";
}

class CourseUrl {
  static String courseInfo = "courses/";
}

class LocationUrl {
  static String country = "user/country";
  static String state = "user/state";
  static String city = "user/city";
}

class StreamsUrl {
  static String getStream = "streams";
}

class StoreUrl {
  static String getProducts = "stores/products";
  static String getCart = "cart";
}
