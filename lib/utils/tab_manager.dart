abstract class TabState {
  void onTabChanged(int tabIndex);
}

class TabManager {
  final TabState tabState;

  TabManager(this.tabState);

  void onTabChanged(int tabIndex) {
    tabState.onTabChanged(tabIndex);
  }
}