import 'package:flutter/material.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFD7DFE5),
        body: BMICalculatorPage(),
      ),
    );
  }
}

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  bool isMale = true;
  int weight = 70;
  int age = 23;
  double height = 0;
  double bmi = 0.0;
  String bmiResult = "Underweight";

  void calculateBMI() {
    if (height > 0) {
      bmi = weight / ((height / 100) * (height / 100));
      if (bmi < 18.5) {
        bmiResult = "Underweight";
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        bmiResult = "Normal";
      } else if (bmi >= 25 && bmi <= 29.9) {
        bmiResult = "Overweight";
      } else {
        bmiResult = "Obese";
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 40),
          Text(
            "Welcome 😊",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            "BMI Calculator",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GenderButton(
                label: "Male",
                icon: Icons.male,
                isSelected: isMale,
                onTap: () {
                  setState(() {
                    isMale = true;
                  });
                },
              ),
              SizedBox(width: 10),
              GenderButton(
                label: "Female",
                icon: Icons.female,
                isSelected: !isMale,
                onTap: () {
                  setState(() {
                    isMale = false;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberInputCard(
                label: "Weight",
                value: weight,
                onIncrement: () {
                  setState(() {
                    weight++;
                  });
                },
                onDecrement: () {
                  setState(() {
                    if (weight > 0) weight--;
                  });
                },
                big: true,
              ),
              SizedBox(width: 20),
              NumberInputCard(
                label: "Age",
                value: age,
                onIncrement: () {
                  setState(() {
                    age++;
                  });
                },
                onDecrement: () {
                  setState(() {
                    if (age > 0) age--;
                  });
                },
                big: true,
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "Height (cm)",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            height: 60,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                height = double.tryParse(value) ?? 0;
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            bmi.toStringAsFixed(1),
            style: TextStyle(fontSize: 50, color: Colors.blue),
            textAlign: TextAlign.center,
          ),
          Text(
            bmiResult,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: calculateBMI,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            child: Text(
              "Lets Go",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  GenderButton({required this.label, required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.blue,
              size: 30,
            ),
            SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberInputCard extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool big;

  NumberInputCard({
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    this.big = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: big ? 150 : 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: big ? 22 : 18)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: Icon(Icons.remove),
                iconSize: big ? 30 : 24,
              ),
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: big ? 36 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: onIncrement,
                icon: Icon(Icons.add),
                iconSize: big ? 30 : 24,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
