import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_2/data/api/api_service.dart';
import 'package:restaurant_app_2/provider/restaurant_provider.dart';
import 'package:restaurant_app_2/utils/debounce.dart';
import 'package:restaurant_app_2/widgets/card_restaurant.dart';

class SearchRestaurantPage extends StatefulWidget {
  static const routeName = '/search_page';

  @override
  _SearchRestaurantPageState createState() => _SearchRestaurantPageState();
}

class _SearchRestaurantPageState extends State<SearchRestaurantPage> {
  static final _debouncer = Debouncer(delay: Duration(milliseconds: 800));

  @override
  Widget build(BuildContext context) {
    //final api = Provider.of<SearchRestaurantProvider>(context);
    // TODO: implement build
    return Scaffold(
        body: ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(apiService: ApiService()),
      child: SafeArea(
          child: Column(
        children: [aaaaa, ccc, Expanded(child: initSearchList)],
      )),
    ));
  }

  Widget ccc = Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 1, color: Colors.black, style: BorderStyle.solid)),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Search Restaurant here..',
                hintStyle: TextStyle(fontSize: 13),
                contentPadding:
                    EdgeInsets.only(left: 15, top: 5, right: 5, bottom: 5),
                isCollapsed: true,
                border: InputBorder.none),
            onChanged: (value) {
              if (value != null && value.length > 2) {
                state.query = value;
                _debouncer.run(() => state.fetchSearchOfRestaurant);
                //  print('First text field: $value ');
              }
            },
          ),
        ),
      ),
    );
  });
}

Widget aaaaa = Container(
  color: Colors.green,
  width: double.infinity,
  child: IntrinsicWidth(
    child: Container(
        padding: const EdgeInsets.only(left: 20, bottom: 10, top: 20),
        child: Text(
          "Search",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        )),
  ),
);

Widget initSearchList = Consumer<SearchRestaurantProvider>(
  builder: (context, state, _) {
    print('query:' + state.query);
    if (state.state == ResultState.Loading) {
      return Center(child: CircularProgressIndicator());
    } else if (state.state == ResultState.HasData) {
      return ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.results.restaurants.length,
        itemBuilder: (context, index) {
          var restaurant = state.results.restaurants[index];
          return SearchCardRestaurant(restaurant: restaurant);
        },
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
