import 'package:carrot_market_sample/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late int _currentPageIndex;
  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return const Home();
      case 1:
        return Container();
        break;
      case 2:
        return Container();
        break;
      case 3:
        break;
        return Container();
      case 4:
        break;
        return Container();
      default:
        return Container();
        break;
    }
    return Container();
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      elevation: 1,
      title: GestureDetector(
        onTap: () {},
        child: Row(
          children: const [Text("성내동"), Icon(Icons.arrow_drop_down)],
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/svg/bell.svg',
              width: 22,
            )),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
        activeIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SvgPicture.asset("assets/svg/${iconName}_on.svg", width: 22),
        ),
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SvgPicture.asset("assets/svg/${iconName}_off.svg", width: 22),
        ),
        label: label);
  }

  Widget _bottomWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      selectedFontSize: 12,
      selectedItemColor: Colors.black,
      currentIndex: _currentPageIndex,
      items: [
        _bottomNavigationBarItem("home", "홈"),
        _bottomNavigationBarItem("notes", "동네생활"),
        _bottomNavigationBarItem("location", "내 근처"),
        _bottomNavigationBarItem("chat", "채팅"),
        _bottomNavigationBarItem("user", "나의 당근"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomWidget(),
    );
  }
}
