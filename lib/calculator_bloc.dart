import 'package:bloc/bloc.dart';

enum Operation {
  plus,
  minus,
  multiple,
  divide
}

abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class CalculatorSuccess extends CalculatorState {
  final int result;

  CalculatorSuccess(this.result);
}

class CalculatorFailed extends CalculatorState {
  final String error;

  CalculatorFailed(this.error);
}

class CalculatorEvent {
  final Operation operation;
  final int numberA;
  final int numberB;

  CalculatorEvent(this.operation, this.numberA, this.numberB);
}

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  @override
  CalculatorState get initialState {
    return CalculatorInitial();
  }

  @override
  Stream<CalculatorState> mapEventToState(CalculatorEvent event) async* {
    int result = 0;
    switch (event.operation) {
      case Operation.plus:
        result = event.numberA + event.numberB;
        yield CalculatorSuccess(result);
        break;
      case Operation.minus:
        result = event.numberA - event.numberB;
        yield CalculatorSuccess(result);
        break;
      case Operation.multiple:
        result = event.numberA * event.numberB;
        yield CalculatorSuccess(result);
        break;
      case Operation.divide:
        result = event.numberA ~/ event.numberB;
        yield CalculatorSuccess(result);
        break;
      default:
        yield CalculatorFailed('Unknown operation');
    }
  }
}
