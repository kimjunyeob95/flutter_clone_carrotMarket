import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_market_sample/components/manor_temperature_widget.dart';
import 'package:flutter/material.dart';

class DetailContentView extends StatefulWidget {
  final Map<String, String> data;
  const DetailContentView({Key? key, required this.data}) : super(key: key);

  @override
  _DetailContentViewState createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  late Size size;
  late List<Map<String, String>> imgList;
  late int _current;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    imgList = [
      {"id": "0", "url": widget.data['image']!},
      {"id": "1", "url": widget.data['image']!},
      {"id": "2", "url": widget.data['image']!},
      {"id": "3", "url": widget.data['image']!},
      {"id": "4", "url": widget.data['image']!},
    ];
    _current = 0;
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            )),
      ],
    );
  }

  Widget _makeSliderImage() {
    return Stack(
      children: [
        Hero(
          tag: widget.data['cid']!,
          child: CarouselSlider(
            options: CarouselOptions(
              height: size.width,
              initialPage: 0,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: imgList.map((element) {
              return Image.asset(
                element["url"]!,
                width: size.width,
                fit: BoxFit.fill,
              );
            }).toList(),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((element) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == int.parse(element['id']!)
                      ? Colors.white
                      : Colors.white.withOpacity(0.4),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.asset('assets/images/user.png').image,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('?????????',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(
                '????????? ?????????',
              ),
            ],
          ),
          Expanded(child: ManorTemperature(manorTemp: 37.5))
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 1,
        color: Colors.grey.withOpacity(0.3));
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(widget.data["title"]!,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const Text("?????????/?????? ?? 22?????? ???",
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 20),
          const Text("???????????? ???????????????\n?????? ??????????????? ????????????.\n????????? ???????????? ?????????.",
              style: TextStyle(height: 1.5, fontSize: 15)),
          const SizedBox(height: 20),
          const Text("?????? 3 ?? ?????? 17 ?? ?????? 295",
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _report() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            'Report this post',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _otherCellContents() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "??????????????? ?????? ??????",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            "????????????",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(slivers: [
      SliverList(
        delegate: SliverChildListDelegate(
          [
            _makeSliderImage(),
            _sellerSimpleInfo(),
            _line(),
            _contentDetail(),
            _line(),
            _report(),
            _line(),
            _otherCellContents(),
          ],
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          delegate: SliverChildListDelegate(List.generate(20, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.grey,
                    height: 120,
                  ),
                ),
                const Text(
                  '?????? ??????',
                  style: TextStyle(fontSize: 14),
                ),
                const Text(
                  '??????',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            );
          }).toList()),
        ),
      )
    ]);
  }

  Widget _bottomBarWidget() {
    return Container(
      height: 55,
      width: size.width,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }
}
