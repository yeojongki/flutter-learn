import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fultter_test/travelBean.dart';

class DetailPage extends StatefulWidget {
  final TravelBean bean;

  DetailPage(this.bean);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final double expandedHeight = 400;
  final double roundedContainerHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            _buildSliverHead(),
            SliverToBoxAdapter(
              child: _buildDetail(),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: SizedBox(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, "我是返回值");
                    // Navigator.of(context).pop("123");
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildSliverHead() {
    return SliverPersistentHeader(
        delegate: DetailSliverDelegate(
            expandedHeight, widget.bean, roundedContainerHeight));
  }

  Widget _buildDetail() {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildUserInfo(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text(
                "The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,"
                "The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,"
                "The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,",
                style:
                    TextStyle(color: Colors.black38, height: 1.4, fontSize: 14),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Featured",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        height: 1.6,
                        fontSize: 18),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: FeatureWidget(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text(
                "The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,"
                "The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,The balearic Lsnaled,",
                style:
                    TextStyle(color: Colors.black38, height: 1.4, fontSize: 14),
              ),
            ),
          ],
        ));
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              widget.bean.url,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.bean.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text("Writer, Wonderlust",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      )),
                ]),
          ),
          Spacer(),
          Icon(Icons.share, color: Colors.black54)
        ],
      ),
    );
  }
}

class FeatureWidget extends StatelessWidget {
  final List<TravelBean> _list = TravelBean.generateMostPopularBean();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15),
      scrollDirection: Axis.horizontal,
      itemCount: _list.length,
      itemBuilder: (context, index) {
        return Container(
            width: 120,
            height: 100,
            margin: EdgeInsets.only(right: 15),
            child: Image.asset(
              _list[index].url,
              fit: BoxFit.cover,
            ));
      },
    );
  }
}

class DetailSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final TravelBean bean;
  final double roundedContainerHeight;

  DetailSliverDelegate(
      this.expandedHeight, this.bean, this.roundedContainerHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
      child: Stack(
        children: <Widget>[
          Hero(
            tag: bean.url,
            child: Image.asset(
              bean.url,
              width: MediaQuery.of(context).size.width,
              height: expandedHeight,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: expandedHeight - roundedContainerHeight - shrinkOffset,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: roundedContainerHeight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
            ),
          ),
          Positioned(
            top: expandedHeight - 150 - shrinkOffset,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(bean.location,
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                Text(bean.name,
                    style: TextStyle(color: Colors.white, fontSize: 30))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
