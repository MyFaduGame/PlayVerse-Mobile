class ApiUrls {
  // static String baseUrl = "http://13.201.229.138/v1/";
  static String baseUrl = "http://192.168.0.113:8000/v1/";
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
  static String soloTournamentRegistrtation = "tournaments/users";
  static String userTournaments = "tournaments/users";
}
