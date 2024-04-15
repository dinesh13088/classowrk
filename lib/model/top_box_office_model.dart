import 'package:flutter/material.dart';

class TopBoxOfficeModel {
  final IconData? icon;
  final String? title;
  final double revenue;
  const TopBoxOfficeModel({
    required this.icon,
    required this.title,
    required this.revenue,
  });
}

final List<TopBoxOfficeModel> topBox = [
  const TopBoxOfficeModel(
    icon: Icons.add,
    title: 'Argylle',
    revenue: 17.0,
  ),

  const TopBoxOfficeModel(
    icon: Icons.add,
    title: 'Episode #4.1',
    revenue: 5.9,
  ),
  const TopBoxOfficeModel(
    icon: Icons.add,
    title: 'The Beekeeper',
    revenue: 5.3,
  ),
  const TopBoxOfficeModel(
    icon: Icons.add,
    title: 'Wonka',
    revenue: 4.7,
  ),
  const TopBoxOfficeModel(
    icon: Icons.add,
    title: 'Migration',
    revenue: 4.2,
  ),
  const TopBoxOfficeModel(
    icon: Icons.add,
    title: 'Mean Girls',
    revenue: 3.8,
  ),
];
