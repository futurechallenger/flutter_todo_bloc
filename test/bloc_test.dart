import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_bloc/bloc/home_bloc.dart';
import 'package:flutter_todo_bloc/repositories/todo_list.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  group('Bloc test', () {
    late MockTodoListRepository mockRepository;

    setUp(() {
      mockRepository = MockTodoListRepository();
    });

    test('load todo list', () {
      expect(TodoListBloc(todoListRepository: mockRepository).state,
          const TodoListInitialState());
    });

    blocTest<TodoListBloc, TodoListState>(
      'emits [TodoListInitialState, TodoListErrorState] when http request throws an error',
      setUp: () => when(mockRepository.fetchTodoList).thenThrow(Exception()),
      build: () => TodoListBloc(todoListRepository: mockRepository),
      act: (bloc) => bloc.add(TodoListRequested()),
      expect: () => <TodoListState>[
        const TodoListInitialState(),
        const TodoListErrorState()
      ],
      verify: (_) => verify(() =>
              mockRepository.fetchTodoList(all: true, completed: 'completed'))
          .called(1),
    );
  });
}
