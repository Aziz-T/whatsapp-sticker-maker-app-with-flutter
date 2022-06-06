import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/providers/home_page_provider/home_page_provider.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';
import 'package:wpstickermaker/widgets/create_stickers_button/create_stickers_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: homePageBody(context),
    );
  }

  Widget homePageBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CreateStickerButton(
            onTap: () {
              context.read<HomePageProvider>().getImage();
            },
          ),
          SizedBox(
            height: 12,
          ),
          buildText()
        ],
      ),
    );
  }

  Text buildText() {
    return Text(
      "Let's create a sticker!",
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'McLaren'),
    );
  }
}
