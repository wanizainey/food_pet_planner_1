import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String petType = 'Cat';
  String activityLevel = 'Normal';
  final TextEditingController weightController = TextEditingController();
  final TextEditingController petCountController = TextEditingController();
  double? foodResult;
  
  //num? get count => null;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('🐾Pet Food Planner🐾',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.2,),),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(2, 4),),],
            ),
            height: 350,
            width: 300,
            child: Column(mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 80, child: Text('Pet Type')),
                    DropdownButton<String>(
                      value: petType,
                      items: <String>['Cat', 'Dog'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),onChanged: (String? newValue) {
                        petType = newValue!;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(width: 80, child: Text('Activity')),
                    DropdownButton<String>(
                      value: activityLevel,
                      items: <String>['Low', 'Normal', 'High'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        activityLevel = newValue!;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(width: 80, child: Text('Weight')),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Weight',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('kg'),
                  ],
                ),
                const SizedBox(height: 5),
                  Row(children: [
                  const SizedBox(width: 80, child: Text('No. of Pets')),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: petCountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: '1',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: calculateFood,
                      child: const Text('Calculate'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: resetFields,
                      child: const Text('Reset'),
                    ),
                  ],
                ),
                if (foodResult != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Recommended: ${foodResult!.toStringAsFixed(1)} g/day',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateFood() {
    double weight = double.tryParse(weightController.text) ?? 0;
    int count = int.tryParse(petCountController.text) ?? 1;

    // kalau user masukkan 0, auto kira as 1
    if (count <= 0) {
        count = 1; }

    if (weight == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your pet weight')),
      );
      return;
    }

    double foodAmount = 0;

    if (petType == 'Cat') {
      if (activityLevel == 'Low') foodAmount = weight * 20;
      else if (activityLevel == 'Normal') foodAmount = weight * 25;
      else foodAmount = weight * 30;
    } else if (petType == 'Dog') {
      if (activityLevel == 'Low') foodAmount = weight * 30;
      else if (activityLevel == 'Normal') foodAmount = weight * 40;
      else foodAmount = weight * 50;
    }

    //var other = null;
    foodResult = foodAmount * count;
    setState(() {});
  }

  void resetFields() {
    weightController.clear();
    petCountController.text = '1';
    petType = 'Cat';
    activityLevel = 'Normal';
    foodResult = null;
    setState(() {});
  }  

  @override
void dispose() {
  weightController.dispose();
  petCountController.dispose();
  super.dispose();
}

}
