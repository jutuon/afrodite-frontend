import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/general/notification/state/like_received.dart";
import "package:app/data/login_repository.dart";
import "package:app/model/freezed/logic/main/bottom_navigation_state.dart";
import "package:rxdart/rxdart.dart";
import 'package:utils/utils.dart';


abstract class BottomNavigationStateEvent {}

class ChangeScreen extends BottomNavigationStateEvent {
  final BottomNavigationScreenId value;
  final bool resetIsScrolledValues;
  ChangeScreen(this.value, {this.resetIsScrolledValues = false});
}
class SetIsScrolledValue extends BottomNavigationStateEvent {
  final BottomNavigationScreenId screen;
  final bool value;
  SetIsScrolledValue(this.screen, this.value);
}
class SetIsTappedAgainValue extends BottomNavigationStateEvent {
  final BottomNavigationScreenId screen;
  final bool value;
  SetIsTappedAgainValue(this.screen, this.value);
}
class BottomNavigationStateBloc extends Bloc<BottomNavigationStateEvent, BottomNavigationStateData> {
  BottomNavigationStateBloc() : super(BottomNavigationStateData()) {
    on<ChangeScreen>((data, emit) {
      final accountBackgroundDb = LoginRepository.getInstance().repositoriesOrNull?.accountBackgroundDb;
      if (data.value == BottomNavigationScreenId.likes && accountBackgroundDb != null) {
        NotificationLikeReceived.getInstance().resetReceivedLikesCount(accountBackgroundDb);
      }

      final bool? resetIsTappedAgainValue = data.value != state.screen ? false : null;

      if (data.resetIsScrolledValues) {
        emit(state.copyWith(
          screen: data.value,
          isScrolledProfile: false,
          isScrolledLikes: false,
          isScrolledChats: false,
          isScrolledSettings: false,
          isTappedAgainProfile: resetIsTappedAgainValue ?? state.isTappedAgainProfile,
          isTappedAgainLikes: resetIsTappedAgainValue ?? state.isTappedAgainLikes,
          isTappedAgainChats: resetIsTappedAgainValue ?? state.isTappedAgainChats,
          isTappedAgainSettings: resetIsTappedAgainValue ?? state.isTappedAgainSettings,
        ));
      } else {
        emit(state.copyWith(
          screen: data.value,
          isTappedAgainProfile: resetIsTappedAgainValue ?? state.isTappedAgainProfile,
          isTappedAgainLikes: resetIsTappedAgainValue ?? state.isTappedAgainLikes,
          isTappedAgainChats: resetIsTappedAgainValue ?? state.isTappedAgainChats,
          isTappedAgainSettings: resetIsTappedAgainValue ?? state.isTappedAgainSettings,
        ));
      }
    });
    on<SetIsScrolledValue>((data, emit) {
      switch (data.screen) {
        case BottomNavigationScreenId.profiles:
          emit(state.copyWith(isScrolledProfile: data.value));
          break;
        case BottomNavigationScreenId.likes:
          emit(state.copyWith(isScrolledLikes: data.value));
          break;
        case BottomNavigationScreenId.chats:
          emit(state.copyWith(isScrolledChats: data.value));
          break;
        case BottomNavigationScreenId.settings:
          emit(state.copyWith(isScrolledSettings: data.value));
          break;
      }
    });
    on<SetIsTappedAgainValue>((data, emit) {
      switch (data.screen) {
        case BottomNavigationScreenId.profiles:
          emit(state.copyWith(isTappedAgainProfile: data.value));
          break;
        case BottomNavigationScreenId.likes:
          emit(state.copyWith(isTappedAgainLikes: data.value));
          break;
        case BottomNavigationScreenId.chats:
          emit(state.copyWith(isTappedAgainChats: data.value));
          break;
        case BottomNavigationScreenId.settings:
          emit(state.copyWith(isTappedAgainSettings: data.value));
          break;
      }
    });
  }

  void updateIsScrolled(
    bool isScrolled,
    BottomNavigationScreenId screen,
    bool Function(BottomNavigationStateData) currentIsScrolledGetter,
  ) {
    final currentIsScrolled = currentIsScrolledGetter(state);
    if (isScrolled != currentIsScrolled) {
      add(SetIsScrolledValue(screen, isScrolled));
    }
  }
}

class BottomNavigationStateBlocInstance extends AppSingletonNoInit {
  static final _instance = BottomNavigationStateBlocInstance._();
  BottomNavigationStateBlocInstance._();
  factory BottomNavigationStateBlocInstance.getInstance() {
    return _instance;
  }

  final BehaviorSubject<BottomNavigationStateBloc> _latestBloc =
    BehaviorSubject.seeded(BottomNavigationStateBloc());

  Stream<BottomNavigationStateData> get navigationStateStream => _latestBloc
    .switchMap((b) => b.stream);

  BottomNavigationStateData get navigationState => _latestBloc.value.state;

  void updateIsScrolled(
    bool isScrolled,
    BottomNavigationScreenId screen,
    bool Function(BottomNavigationStateData) currentIsScrolledGetter,
  ) {
    _latestBloc.value.updateIsScrolled(isScrolled, screen, currentIsScrolledGetter);
  }

  void setLatestBloc(BottomNavigationStateBloc newBloc) {
    if (_latestBloc.value != newBloc) {
      _latestBloc.add(newBloc);
    }
  }
}

enum BottomNavigationScreenId {
  profiles(0),
  likes(1),
  chats(2),
  settings(3);

  final int screenIndex;
  const BottomNavigationScreenId(this.screenIndex);
}
