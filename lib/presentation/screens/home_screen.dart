import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/presentation/UI/custom_button.dart';
import '/presentation/UI/custom_text.dart';
import '/logic/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/binary_model.dart';
import '/resources/api_provider.dart';

import '../../core/locator.dart';
import '../../main.dart';
import '../../services/local_storage_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          counter = localStorageService.getCounter();
          return BlocProvider<CounterBloc>(
              create: (context) => CounterBloc(counter),
              child: Scaffold(
                appBar: AppBar(
                  title: Center(child: Text(widget.title)),
                ),
                body: CounterPage(
                  localStorageService: localStorageService,
                ),
                bottomNavigationBar: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customButton('-', context),
                      customButton('+', context),
                    ],
                  ),
                ),
              ));
        });
  }
}

// ignore: must_be_immutable
class CounterPage extends StatelessWidget {
  int _counter = 0;
  String? _binary = '0';
  final ApiProvider _client = ApiProvider();

  initState() async {
    await setupLocator();
    LocalStorageService localStorageService = locator<LocalStorageService>();
    counter = localStorageService.getCounter();
  }

  final LocalStorageService localStorageService;
  CounterPage({
    Key? key,
    required this.localStorageService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    counter = localStorageService.getCounter();
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          localStorageService.setCounter(state.counterValue);
          return FutureBuilder<BinaryModel?>(
              future: _client.fetchBinaryList(number: state.counterValue),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  BinaryModel? data = snapshot.data;
                  if (data != null) {
                    _binary = data.converted;
                    _counter = state.counterValue;
                    return customText(_counter, _binary, true, context);
                  }
                }
                return customText(_counter, _binary, false, context);
              });
        },
      ),
    ]);
  }
}
