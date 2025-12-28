import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_chat/features/home/bloc/home_bloc.dart';
import 'package:mini_chat/features/home/bloc/home_event.dart';
import 'package:mini_chat/features/home/bloc/home_state.dart';

void main() {
  group('HomeBloc Tests', () {
    late HomeBloc bloc;

    setUp(() {
      bloc = HomeBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is correct', () {
      expect(
        bloc.state,
        isA<HomeState>()
            .having((s) => s.selectedTab, 'selectedTab', 0)
            .having((s) => s.users.length, 'users', 0),
      );
    });

    blocTest<HomeBloc, HomeState>(
      'emits updated users list when AddUser is added',
      build: () => bloc,
      act: (bloc) => bloc.add(AddUser('John')),
      expect: () => [
        isA<HomeState>()
            .having((s) => s.users.length, 'users length', 1),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'switches tab correctly',
      build: () => bloc,
      act: (bloc) => bloc.add(SwitchTab(1)),
      expect: () => [
        isA<HomeState>()
            .having((s) => s.selectedTab, 'selectedTab', 1),
      ],
    );
  });
}
