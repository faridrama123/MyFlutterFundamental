import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_2/data/api/api_service.dart';
import 'package:restaurant_app_2/data/model/detail_restaurant.dart';
import 'package:restaurant_app_2/provider/restaurant_provider.dart';

class DetailRestaurantPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final String id;

  const DetailRestaurantPage({this.id});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) =>
          DetailRestaurantProvider(apiService: ApiService(), restaurantid: id),
      child: _buildList(),
    ));
  }

  Widget _buildList() {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          var restaurant = state.results.restaurant;
          return DetailContent(
            detailRestaurant: restaurant,
          );
        } else if (state.state == ResultState.NoData) {
          return Center(
              child: Text(
            state.message,
            textAlign: TextAlign.center,
          ));
        } else if (state.state == ResultState.Error) {
          return Center(
              child: Text(
            state.message,
            textAlign: TextAlign.center,
          ));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
}

class DetailContent extends StatelessWidget {
  int count = 0;
  final DetailRestaurant detailRestaurant;
  List<Category> menus;
  List<Color> colors = [
    Colors.brown,
    Colors.cyan,
    Colors.pink,
    Colors.limeAccent,
    Colors.lightGreen,
    Colors.amber,
    Colors.lightBlue,
    Colors.blueGrey
  ];

  List<IconData> icons = [
    Icons.food_bank,
    Icons.access_alarms,
    Icons.icecream,
    Icons.masks_sharp,
    Icons.face,
    Icons.keyboard
  ];

  DetailContent({this.detailRestaurant}) {
    menus = detailRestaurant.menus.foods;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/small/" +
                          detailRestaurant.pictureId),
                ),
                SafeArea(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FavoriteButton()
                  ],
                )),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      detailRestaurant.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                    Row(children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Padding(padding: EdgeInsets.all(1)),
                      Text(
                        detailRestaurant.rating.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ]),
                  ]),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: menus.map((item) {
                        var randomColor = (colors..shuffle()).first;
                        var randomIconData = (icons..shuffle()).first;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              color: randomColor,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      randomIconData,
                                      size: 40,
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 7.0, right: 7.0, top: 10.0),
                                        width: 100,
                                        child: Text(
                                          item.name,
                                          textAlign: TextAlign.center,
                                        )),
                                  ]),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      detailRestaurant.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
