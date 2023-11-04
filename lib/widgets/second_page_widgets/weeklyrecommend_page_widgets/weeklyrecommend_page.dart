import 'package:books_app/cubit/api_connection_cubit.dart';
import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/connection_state_extention.dart';
import 'package:books_app/utils/screen_size.dart';
import 'package:books_app/utils/text_styles.dart';
import 'package:books_app/widgets/second_page_widgets/weeklyrecommend_page_widgets/weeklyrecommend_oval.dart';
import 'package:books_app/widgets/oval_reading/oval_reading_widget.dart';
import 'package:books_app/widgets/title_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeeklyRecommendPage extends StatefulWidget {
  const WeeklyRecommendPage({super.key});

  @override
  State<WeeklyRecommendPage> createState() => _WeeklyRecommendPageState();
}

class _WeeklyRecommendPageState extends State<WeeklyRecommendPage> {
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreenSize = ScreenSize(context);
    final apiState = context.watch<ApiConnectionCubit>().state;
    final isConnected = apiState.toBool();

    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orange,
          content: Text(isConnected
                  ? 'Succesfully connected to the network'
                  : 'Check your internet connection')
              .noConnectionInternetTextStyle(),
        ),
      );
    });
    return Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.topStart,
        children: [
          const Padding(padding: EdgeInsets.only(top: 25)),
          const TitlePage(typeofPage: 'Weekly recommendation'),
          Padding(
              padding: const EdgeInsets.only(top: 340),
              child: SizedBox(
                width: myScreenSize.screenWidth,
                child: const OvalReadingWidget(oval: 'weekly'),
              )),
          Padding(
              padding: const EdgeInsets.only(top: 320),
              child: Container(
                height: 4,
                width: myScreenSize.screenWidth * 0.3,
                color: Colores.greenflour,
              )),
          Padding(
              padding: const EdgeInsets.only(top: 85),
              child: SizedBox(
                  height: myScreenSize.screenHeight * 0.4,
                  child: const OvalRecommendWidget())),
          Padding(
              padding: const EdgeInsets.only(
                top: 550,
              ),
              child: Container(
                height: 4,
                width: myScreenSize.screenWidth * 0.6,
                color: Colores.greenflour,
              )),
        ]);
  }
}
