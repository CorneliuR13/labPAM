import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<Map<String, dynamic>> loadWineData() async {
    String jsonString = await rootBundle.loadString('assets/v3.json');
    return json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WineShopScreen(loadWineData: loadWineData),
    );
  }
}

class WineShopScreen extends StatelessWidget {
  final Future<Map<String, dynamic>> Function() loadWineData;

  WineShopScreen({required this.loadWineData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.black),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Donnerville Drive',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.black),
                  ],
                ),
                Text(
                  '4 Donnerville Hall, Donnerville Drive, Adamston...',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.notifications_none, color: Colors.grey),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: Text(
                        '12',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: loadWineData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading data'));
            } else {
              final wineData = snapshot.data!;
              final wines = wineData['carousel'] as List<dynamic>;

              return ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.mic),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Shop wines by',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WineFilterButton(label: 'Type', isActive: true),
                      WineFilterButton(label: 'Style', isActive: false),
                      WineFilterButton(label: 'Countries', isActive: false),
                      WineFilterButton(label: 'Grape', isActive: false),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Wine Categories',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        WineCategoryCard(
                          image: 'images/redwine.png',
                          title: 'Red wines',
                          count: 123,
                        ),
                        WineCategoryCard(
                          image: 'images/whitewine.png',
                          title: 'White wines',
                          count: 123,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wine',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('View all'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ...wines.map((wine) {
                    return WineCard(
                      image: wine['image'] ?? '',
                      wineName: wine['name'] ?? 'Unknown',
                      wineType: wine['type'] ?? 'Unknown',
                      wineDescription:
                          wine['description'] ?? 'No description available',
                      winePrice: '₹ ${wine['price_usd'] ?? '0'}',
                      country:
                          '${wine['from']['city'] ?? 'Unknown'}, ${wine['from']['country'] ?? 'Unknown'}',
                      criticScore: '${wine['critic_score'] ?? '0'}/100',
                    );
                  }).toList(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

// Wine Filter Button Widget
class WineFilterButton extends StatelessWidget {
  final String label;
  final bool isActive;

  WineFilterButton({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: isActive ? Color(0xFFBE2C55) : Colors.black,
            backgroundColor: isActive ? Color(0xFFF5DFE5) : Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side:
                  BorderSide(color: isActive ? Color(0xFFBE2C55) : Colors.grey),
            ),
          ),
          onPressed: () {},
          child: Text(label),
        ),
      ),
    );
  }
}

// Wine Category Card Widget
class WineCategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final int count;

  WineCategoryCard({
    required this.image,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                image,
                width: 100,
                height: 100,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }
}

// Wine Card Widget
class WineCard extends StatelessWidget {
  final String wineName;
  final String wineType;
  final String wineDescription;
  final String winePrice;
  final String country;
  final String criticScore;
  final String image;

  WineCard({
    required this.wineName,
    required this.wineType,
    required this.wineDescription,
    required this.winePrice,
    required this.country,
    required this.criticScore,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  image,
                  width: 100,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: Center(
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    );
                  },
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wineName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          text: wineType,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: ' · $country',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        wineDescription,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        winePrice,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          SizedBox(width: 4),
                          Text(criticScore),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
