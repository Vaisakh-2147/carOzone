import 'package:car_o_zone/screens/hive/save_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:car_o_zone/screens/hive/model/car_comparison.dart';

class SavedDataListScreen extends StatefulWidget {
  const SavedDataListScreen({Key? key}) : super(key: key);

  @override
  _SavedDataListScreenState createState() => _SavedDataListScreenState();
}

class _SavedDataListScreenState extends State<SavedDataListScreen> {
  Box<CarComparison>? _comparisonBox;

  @override
  void initState() {
    super.initState();
    _openComparisonBox();
  }

  Future<void> _openComparisonBox() async {
    _comparisonBox = await Hive.openBox<CarComparison>('car_comparison');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Data List',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
      ),
      body: _comparisonBox == null
          ? const Center(child: CircularProgressIndicator())
          : _buildList(),
    );
  }

  Widget _buildList() {
    final dataList = _comparisonBox!.values.toList();
    if (dataList.isEmpty) {
      return const Center(child: Text('No data available'));
    } else {
      return ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final comparisonData = dataList[index];
          return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Deleted ${comparisonData.text} vs ${comparisonData.secondText}'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {},
                    ),
                  ),
                );
                setState(() {
                  _comparisonBox!.delete(comparisonData.key);
                });
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SavecompareScreen(
                          text: comparisonData.text,
                          prize: comparisonData.prize,
                          fueltype: comparisonData.fueltype,
                          transmission: comparisonData.transmission,
                          enginesize: comparisonData.enginesize,
                          mileage: comparisonData.mileage,
                          safetyrating: comparisonData.safetyrating,
                          groundclearance: comparisonData.groundclearance,
                          seatingcapacity: comparisonData.seatingcapacity,
                          carsize: comparisonData.carsize,
                          carfueltank: comparisonData.carfueltank,
                          imageUrl: comparisonData.imageUrl,
                          secondImageUrl: comparisonData.secondImageUrl,
                          secondText: comparisonData.secondText,
                          secondCarfueltank: comparisonData.carfueltank,
                          secondPrize: comparisonData.secondPrize,
                          secondCarsize: comparisonData.secondCarsize,
                          secondSeatingcapacity:
                              comparisonData.secondSeatingcapacity,
                          secondGroundclearance:
                              comparisonData.secondGroundclearance,
                          secondSafetyrating: comparisonData.secondSafetyrating,
                          secondMileage: comparisonData.secondMileage,
                          secondEnginesize: comparisonData.secondEnginesize,
                          secondTransmission: comparisonData.secondTransmission,
                          secondFueltype: comparisonData.secondFueltype)));
                },
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 6, 85, 223)),
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color.fromARGB(255, 227, 69, 156),
                    ),
                    child: Text(
                        ' ${comparisonData.text} vs ${comparisonData.secondText}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
              ));
        },
      );
    }
  }
}
