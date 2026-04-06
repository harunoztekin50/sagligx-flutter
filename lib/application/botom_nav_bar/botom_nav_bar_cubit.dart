import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'botom_nav_bar_state.dart';

class BotomNavBarCubit extends Cubit<BotomNavBarState> {
  BotomNavBarCubit() : super(BotomNavBarState.inital());

  void selcetTab(BotomNavBarTab tab) {
    emit(state.copyWith(tabOption: some(tab)));
  }
}
