import 'package:carrot_market_sample/pages/detail.dart';
import 'package:carrot_market_sample/repository/contents_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _currentLocation;
  final ContentsRepository contentsRepository = ContentsRepository();
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
  }

  final oCcy = NumberFormat("#,###", "ko_KR");
  String calcStringToWon(String priceString) {
    if (priceString == "무료나눔") return priceString;
    return "${oCcy.format(int.parse(priceString))}원";
  }

  _loadContents() {
    return contentsRepository.loadContentsFromLocation(_currentLocation);
  }

  _makeDataList(List<Map<String, String>> datas) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext _context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return DetailContentView(
                  data: datas[index],
                );
              }));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Hero(
                      tag: datas[index]['cid']!,
                      child: Image.asset(
                        datas[index]['image']!,
                        width: 100,
                        height: 100,
                      ),
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

  Widget _bodyWidget() {
    return FutureBuilder<List<Map<String, String>>>(
        future: _loadContents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('오류'),
            );
          }

          if (snapshot.hasData) {
            return _makeDataList(snapshot.data ?? []);
          }

          return const Center(
            child: Text('해당 지역에 데이터가 없습니다.'),
          );
        });
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
