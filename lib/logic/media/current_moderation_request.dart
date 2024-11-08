
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:app/api/api_manager.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/media_repository.dart";
import "package:app/model/freezed/logic/media/current_moderation_request.dart";
import "package:app/ui/normal/settings/media/retry_initial_setup_images.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";

final log = Logger("CurrentModerationRequestBloc");

// TODO(prod): Is current moderation request refreshed every time app opens
// to profile grid view?
// Probably only when initial moderation request is ongoing.

sealed class CurrentModerationRequestEvent {}
class Reload extends CurrentModerationRequestEvent {}
class ReloadOnceConnected extends CurrentModerationRequestEvent {}
class SendNewModerationRequest extends CurrentModerationRequestEvent {
  Iterable<ContentId> data;
  SendNewModerationRequest(this.data);
}
class SendRetryInitialSetupImages extends CurrentModerationRequestEvent {
  RetryInitialSetupImages data;
  SendRetryInitialSetupImages(this.data);
}
class DeleteCurrentModerationRequest extends CurrentModerationRequestEvent {}


class CurrentModerationRequestBloc extends Bloc<CurrentModerationRequestEvent, CurrentModerationRequestData> with ActionRunner {
  final MediaRepository media = LoginRepository.getInstance().repositories.media;
  final ServerConnectionManager connectionManager = LoginRepository.getInstance().repositories.connectionManager;

  CurrentModerationRequestBloc() : super(CurrentModerationRequestData()) {
    on<Reload>((data, emit) async {
      await runOnce(() async {
        emit(CurrentModerationRequestData().copyWith(isLoading: true));
        await reload(emit);
      });
    });
    on<ReloadOnceConnected>((data, emit) async {
      await runOnce(() async {
        emit(CurrentModerationRequestData().copyWith(isLoading: true));
        await connectionManager.state.firstWhere((element) => element == ApiManagerState.connected);
        await reload(emit);
      });
    });
    on<SendNewModerationRequest>((data, emit) async {
      await runOnce(() async {
        emit(CurrentModerationRequestData().copyWith(isLoading: true));
        final result = await media.createNewModerationRequest(data.data.toList());
        switch (result) {
          case Ok():
            await reload(emit);
          case Err():
            emit(CurrentModerationRequestData().copyWith(isLoading: false, isError: true));
        }
      });
    });
    on<DeleteCurrentModerationRequest>((data, emit) async {
      await runOnce(() async {
        emit(CurrentModerationRequestData().copyWith(isLoading: true));
        final result = await media.deleteCurrentModerationRequest();
        switch (result) {
          case Ok():
            await reload(emit);
          case Err():
            emit(CurrentModerationRequestData().copyWith(isLoading: false, isError: true));
        }
      });
    });
    on<SendRetryInitialSetupImages>((data, emit) async {
      await runOnce(() async {
        emit(CurrentModerationRequestData().copyWith(isLoading: true));
        final result = await media.retryInitialSetupImages(data.data);
        switch (result) {
          case Ok():
            await reload(emit);
          case Err():
            emit(CurrentModerationRequestData().copyWith(isLoading: false, isError: true));
        }
      });
    });
  }

  Future<void> reload(Emitter<CurrentModerationRequestData> emit) async {
    final value = await media.currentModerationRequestState();

    switch (value) {
      case Ok(:final v):
        emit(state.copyWith(
          moderationRequest: v,
          isLoading: false
        ));
      case Err():
        emit(state.copyWith(
          isLoading: false,
          isError: true
        ));
    }
  }
}
