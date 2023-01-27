import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CarouselSlider(items: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(image: DecorationImage(
          fit: BoxFit.fill,
            image: AssetImage('assets/images/popular_foods/ic_popular_food_1.png'))),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/popular_foods/ic_popular_food_2.png'))),
      )
    ], options: CarouselOptions(autoPlay: true,viewportFraction: 1,));
  }

}