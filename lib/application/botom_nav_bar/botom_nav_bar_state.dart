part of 'botom_nav_bar_cubit.dart';

final class BotomNavBarState extends Equatable {
  const BotomNavBarState({required this.tabOption});

  final Option<BotomNavBarTab> tabOption;

  factory BotomNavBarState.inital() {
    return BotomNavBarState(tabOption: Some(BotomNavBarTab.album));
  }

  BotomNavBarState copyWith({
    required Option<BotomNavBarTab>? tabOption,
  }) {
    return BotomNavBarState(tabOption: tabOption ?? this.tabOption);
  }

  int get curentIndex {
    return tabOption.fold(() => 0, (tab) => tab.index);
  }

  List<BotomNavBarTab> get tabs => BotomNavBarTab.values;

  @override
  List<Object> get props => [tabOption];
}

enum BotomNavBarTab {
  album(Icons.image_outlined, "Album"),
  settings(Icons.settings_outlined, "Settings");

  const BotomNavBarTab(this.icon, this.label);
  final IconData icon;
  final String label;
}
