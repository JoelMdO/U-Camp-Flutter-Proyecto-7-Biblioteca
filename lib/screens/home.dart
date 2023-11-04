import 'package:books_app/cubit/api_connection_cubit.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/buttons/button_book_purple/button_bookpurple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ScreenSize myScreenSize = ScreenSize(context);

    return Scaffold(
        body: SafeArea(
            top: true,
            bottom: true,
            right: true,
            left: true,
            child: Container(
                width: myScreenSize.screenWidth,
                height: myScreenSize.screenHeight,
                decoration: const BoxDecoration(color: Colors.white),
                child: Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Positioned(
                          top: 90,
                          left: 0,
                          child: Image.asset(
                            'assets/Circlehome.png',
                            width: myScreenSize.screenWidth * 0.44,
                            fit: BoxFit.cover,
                          )),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          child: Image.asset(
                            'assets/Boy.png',
                            height: myScreenSize.screenHeight * 0.7,
                            fit: BoxFit.cover,
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/Pileofbooks.png',
                            height: myScreenSize.screenHeight * 0.22,
                            fit: BoxFit.cover,
                          )),
                      Positioned(
                        top: 100,
                        left: 200,
                        child: const Text('Litera').homePageTitleStyle(),
                      ),
                      Positioned(
                          top: 300,
                          left: 290,
                          child: BlocBuilder<ApiConnectionCubit,
                              ApiConnectionState>(builder: (context, state) {
                            return const ButtonBookPurple(buttonType: 'Start');
                          }))
                    ]))));
  }
}
