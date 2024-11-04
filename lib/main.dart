import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WineShopScreen(),
    );
  }
}

class WineShopScreen extends StatelessWidget {
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
            padding: const EdgeInsets.only(
                right: 16.0), // Adjust the right padding as needed
            child: Stack(
              clipBehavior:
                  Clip.none, // Ensures the badge is visible outside the icon
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors
                        .grey[200], // Background color for the icon button
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    border: Border.all(color: Colors.grey), // Border color
                  ),
                  child: IconButton(
                    icon: Icon(Icons.notifications_none,
                        color: Colors.grey), // Grey icon
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  right: -4, // Slightly offset the position to the top-right
                  top: -4,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle, // Circular badge
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: Text(
                        '12', // Notification count
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
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
        child: ListView(
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WineFilterButton(label: 'Type', isActive: true), // Red button
                WineFilterButton(
                    label: 'Style', isActive: false), // Grey button
                WineFilterButton(
                    label: 'Countries', isActive: false), // Grey button
                WineFilterButton(
                    label: 'Grape', isActive: false), // Grey button
              ],
            ),
            SizedBox(height: 16),
            // Wine categories section
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
            // Wine list section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Wine',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('View all'),
                ),
              ],
            ),
            SizedBox(height: 16),
            WineCard(
              image: 'images/redbottle.png',
              wineName: 'Ocone Bozzovich Beneventano Bianco IGT',
              wineType: 'Red wine',
              wineDescription: '(Green and Flinty)',
              winePrice: '₹ 23,256,596',
              country: 'Champagne, France',
              criticScore: '94/100',
            ),
            WineCard(
              image: 'images/whitebottle.png',
              wineName: '2021 Petit Chablis Passy Le Clou',
              wineType: 'White Wine',
              wineDescription: '(Green and Flinty)',
              winePrice: '₹ 23,256,596',
              country: 'Champagne, France',
              criticScore: '94/100',
            ),
             WineCard(
              image: 'images/rosebottle.png',
              wineName: 'Philippe Fontaine Champagne Brut Rose, Rose de Saignee, NV',
              wineType: 'Sparkling Wine',
              wineDescription: '(Green and Flinty)',
              winePrice: '₹ 23,256,596',
              country: 'Champagne, France',
              criticScore: '94/100',
            ),
             WineCard(
              image: 'images/cicada.png',
              wineName: '2021 Cicada`s Sonf Rose',
              wineType: 'Rose Wine',
              wineDescription: '(Green and Flinty)',
              winePrice: '₹ 23,256,596',
              country: 'Champagne, France',
              criticScore: '94/100',
            ),
          ],
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
            backgroundColor: isActive
                ? Color(0xFFF5DFE5  )
                : Colors.grey[200], // Text color changes based on button state
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: isActive ? Color(0xFFBE2C55) : Colors.grey),
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
                // Replace this URL with your actual wine image
                Image.asset(
                  image,
                  width: 100,
                  height: 150,
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
                          children: [
                            TextSpan(
                              text: wineType,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: wineDescription,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('From $country'),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(Icons.favorite_border),
                            label: Text('Favourite'),
                            onPressed: () {},
                          ),
                          SizedBox(width: 16),
                          Text(
                            winePrice,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Critics\' Scores: $criticScore'),
          ],
        ),
      ),
    );
  }
}
