import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/theme/theme_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/welcome/welcome_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Task Manager',
          theme: context.read<ThemeBloc>().themeData,
          home: const WelcomeScreen(),
        );
      },
    );
  }
}

  // var colorsList = [Colors.blue, Colors.orange, Colors.green];
  // List<List<String>> data = [
  //   ["todo1", "todo2", "todo3"],
  //   ["inprogress1", "inprogress2", "inprogress3"],
  //   ["done1", "done2", "done3"]
  // ];
  // ScrollController scrollController = ScrollController();
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //       title: Text(
  //         context.read<ProjectBloc>().currentProject?.name ?? '',
  //         style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //     drawer: const Drawer(),
  //     body: Center(
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: SingleChildScrollView(
  //               controller: scrollController,
  //               physics: const BouncingScrollPhysics(),
  //               scrollDirection: Axis.horizontal,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [0, 1, 2]
  //                     .map(
  //                       (i) => DragTarget<Map>(onAcceptWithDetails: (details) {
  //                         setState(() {
  //                           print(details.data.toString());
  //                            if (!data[i].contains(details.data['data'])) {
  //                             data[details.data['source']].remove(details.data['data']);
  //                             data[i].add(details.data['data']);
  //                           }
  //                         });
  //                         print(details.data);
  //                       }, builder: (
  //                         BuildContext context,
  //                         List<dynamic> accepted,
  //                         List<dynamic> rejected,
  //                       ) {
  //                         return ColumnWidget(color: colorsList[i], scrollController: scrollController, data: data[i], id: i);
  //                       }),
  //                     )
  //                     .toList(),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

