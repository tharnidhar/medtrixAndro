import 'package:flutter_riverpod/flutter_riverpod.dart';

class SmartLink {
  final int timeSeconds;
  final int page;
  SmartLink(this.timeSeconds, this.page);
}

class SmartLinkController extends Notifier<List<SmartLink>> {
  @override
  List<SmartLink> build() => [];

  void addLink(int time, int page) {
    state = [...state, SmartLink(time, page)]..sort(
      (a, b) => a.timeSeconds.compareTo(b.timeSeconds),
    );
  }

  int? pageForTime(int currentSeconds) {
    for (int i = state.length - 1; i >= 0; i--) {
      if (currentSeconds >= state[i].timeSeconds) {
        return state[i].page;
      }
    }
    return null;
  }
}

final smartLinkProvider =
    NotifierProvider<SmartLinkController, List<SmartLink>>(
        SmartLinkController.new);
