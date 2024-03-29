import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) {
          return CounterCubit();
        },
        child: _CubicCounterView());
  }
}

class _CubicCounterView extends StatelessWidget {
  const _CubicCounterView({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final counterState = context.watch<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: context.select((CounterCubit value) {
          return Text('Cubit Counter: ${value.state.transactionCount}');
        },),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CounterCubit>().reset();
            }, 
            icon: const Icon(Icons.refresh_outlined))
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          // buildWhen: (previous, current) => current.counter != previous.counter,
          builder: (context, state) {
            print('Counter cambio');
            return Text('Counter value: ${state.transactionCount}');
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().increaseBy(3);
            },
            heroTag: '1',
            child: const Text('+3'),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().increaseBy(2);
            },
            heroTag: '2',
            child: const Text('+2'),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().increaseBy(1);
            },
            heroTag: '3',
            child: const Text('+1'),
          ),
        ],
      ),
    );
  }
}
