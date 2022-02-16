import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> datas = [];
  late String _currentLocation;
  final Map<String, String> locationTypeToString = {
    "성내동": "성내동",
    "천호동": "천호동",
    "길동": "길동",
    "둔촌동": "둔촌동",
  };
  @override
  void initState() {
    super.initState();
    _currentLocation = "성내동";
    datas = [
      {
        "image": "assets/images/ara-1.jpg",
        "title": "네메시스 축구화275",
        "location": "제주 제주시 아라동",
        "price": "30000",
        "likes": "2"
      },
      {
        "image": "assets/images/ara-2.jpg",
        "title": "LA갈비 5kg팔아요~",
        "location": "제주 제주시 아라동",
        "price": "100000",
        "likes": "5"
      },
      {
        "image": "assets/images/ara-3.jpg",
        "title": "치약팝니다",
        "location": "제주 제주시 아라동",
        "price": "5000",
        "likes": "0"
      },
      {
        "image": "assets/images/ara-4.jpg",
        "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
        "location": "제주 제주시 아라동",
        "price": "2500000",
        "likes": "6"
      },
      {
        "image": "assets/images/ara-5.jpg",
        "title": "디월트존기임팩",
        "location": "제주 제주시 아라동",
        "price": "150000",
        "likes": "2"
      },
      {
        "image": "assets/images/ara-6.jpg",
        "title": "갤럭시s10",
        "location": "제주 제주시 아라동",
        "price": "180000",
        "likes": "2"
      },
      {
        "image": "assets/images/ara-7.jpg",
        "title": "선반",
        "location": "제주 제주시 아라동",
        "price": "15000",
        "likes": "2"
      },
      {
        "image": "assets/images/ara-8.jpg",
        "title": "냉장 쇼케이스",
        "location": "제주 제주시 아라동",
        "price": "80000",
        "likes": "3"
      },
      {
        "image": "assets/images/ara-9.jpg",
        "title": "대우 미니냉장고",
        "location": "제주 제주시 아라동",
        "price": "30000",
        "likes": "3"
      },
      {
        "image": "assets/images/ara-10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다.",
        "location": "제주 제주시 아라동",
        "price": "50000",
        "likes": "7"
      }
    ];
  }

  final oCcy = NumberFormat("#,###", "ko_KR");
  String calcStringToWon(String priceString) {
    return "${oCcy.format(int.parse(priceString))}원";
  }

  Widget _bodyWidget() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext _context, int index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    datas[index]['image']!,
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datas[index]['title']!,
                          style: const TextStyle(
                              fontSize: 15, overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          datas[index]['location']!,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.3)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          calcStringToWon(datas[index]['price']!),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/heart_off.svg',
                                width: 13,
                                height: 13,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(datas[index]['likes']!),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext _context, int index) {
          return Container(
            height: 1,
            color: Colors.black.withOpacity(0.4),
          );
        },
        itemCount: datas.length);
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      elevation: 1,
      title: GestureDetector(
        onTap: () {},
        child: PopupMenuButton<String>(
          offset: const Offset(0, 20),
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              10),
          onSelected: (String where) {
            setState(() {
              _currentLocation = where;
            });
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text('둔촌동'),
                value: "둔촌동",
              ),
              const PopupMenuItem(child: Text('길동'), value: "길동"),
              const PopupMenuItem(child: Text('천호동'), value: "천호동"),
              const PopupMenuItem(child: Text('성내동'), value: "성내동"),
            ];
          },
          child: Row(
            children: [
              Text(locationTypeToString[_currentLocation] as String),
              const Icon(Icons.arrow_drop_down)
            ],
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}
