import 'package:flutter/material.dart';
import 'package:restaurant_app_2/common/styles.dart';
import 'package:restaurant_app_2/data/model/list_restaurant.dart';
import 'package:restaurant_app_2/data/model/search_restaurant.dart';
import 'package:restaurant_app_2/ui/detail_restaurant_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: "https://restaurant-api.dicoding.dev/images/small/" +
              restaurant.pictureId,
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/small/" +
                restaurant.pictureId,
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Text(restaurant.city),
        onTap: () => Navigator.pushNamed(
          context,
          DetailRestaurantPage.routeName,
          arguments: restaurant.id,
        ),
      ),
    );
  }
}

class SearchCardRestaurant extends StatelessWidget {
  final SearchRestaurant restaurant;

  const SearchCardRestaurant({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: "https://restaurant-api.dicoding.dev/images/small/" +
              restaurant.pictureId,
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/small/" +
                restaurant.pictureId,
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Text(restaurant.city),
        onTap: () => Navigator.pushNamed(
          context,
          DetailRestaurantPage.routeName,
          arguments: restaurant.id,
        ),
      ),
    );
  }
}
