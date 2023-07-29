import 'package:counter_bloc_lib/bloc/color_bloc/color_bloc.dart';
import 'package:counter_bloc_lib/bloc/counter_bloc/counter_bloc.dart';
import 'package:counter_bloc_lib/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CounterBloc>(
            create: (context) => CounterBloc(),
          ),
          BlocProvider<ColorBloc>(
            create: (context) => ColorBloc(),
          ),
        ],
        child: ChangeNotifierProvider(
            create: (context) => ClassName(),
            child: const MyHomePage(title: 'Flutter Demo Home Page')),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CounterBloc counterBloc;
  late ColorBloc colorBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    counterBloc = context.read<CounterBloc>();
    colorBloc = context.read<ColorBloc>();
  }

  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<ColorBloc, ColorState>(
                builder: (context, state) {
                  print('color');
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: state.width,
                    height: state.width,
                    decoration: BoxDecoration(
                        color: state.color,
                        borderRadius: BorderRadius.circular(20)),
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              BlocSelector<CounterBloc, CounterState, int>(
                selector: (state) {
                  return state.count;
                },
                builder: (context, state) {
                  return Text(
                    state.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: ButtonBar(
          children: [
            FloatingActionButton(
              onPressed: () {
                counterBloc.add(IncrementEvent());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                counterBloc.add(DecrementEvent());
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: () {
                colorBloc.add(RedColorEvent());
              },
              tooltip: 'RED',
              backgroundColor: Colors.red,
            ),
            FloatingActionButton(
              onPressed: () {
                colorBloc.add(BlueColorEvent());
              },
              tooltip: 'BLUE',
              backgroundColor: Colors.blue,
            ),
            FloatingActionButton(
              onPressed: () {
                colorBloc.add(BlueGreyColorEvent());
              },
              tooltip: 'BLUEGREY',
              backgroundColor: Colors.blueGrey,
            ),
          ],
        ));
  }
}
