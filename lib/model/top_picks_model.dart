import 'package:flutter/material.dart';

class TopPicksModel{
  final IconData? icon;
  final String? url;
  final double? rate;
  final String? title;
  TopPicksModel({
    this.icon,this.rate,this.title,this.url
  }

  );
}
List<TopPicksModel> topPicks=[
  TopPicksModel(icon: Icons.add,url:'https://i.ibb.co/TbJ9cwZ/movie3.jpg' ,rate: 7.1,title: 'Salburn'),
  TopPicksModel(icon: Icons.add,url: 'https://i.ibb.co/QCT5fMF/movie2.jpg',rate: 7.7,title: 'Hazbin Hotel',),
  TopPicksModel(icon: Icons.add, url:'https://i.ibb.co/XVYT7M7/movie1.jpg',rate: 6.7, title: 'Reacher') ,
];