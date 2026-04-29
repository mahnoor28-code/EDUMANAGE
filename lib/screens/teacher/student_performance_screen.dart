import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StudentPerformanceScreen extends StatefulWidget {
  const StudentPerformanceScreen({super.key});

  @override
  State<StudentPerformanceScreen> createState() => _StudentPerformanceScreenState();
}

class _StudentPerformanceScreenState extends State<StudentPerformanceScreen> {
  String? _selectedClass;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Select Class',
              ),
              items: const [
                DropdownMenuItem(value: '10A', child: Text('Class 10A')),
                DropdownMenuItem(value: '10B', child: Text('Class 10B')),
                DropdownMenuItem(value: '9A', child: Text('Class 9A')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
            ),
            const SizedBox(height: 20),
            if (_selectedClass == null)
              const Expanded(
                child: Center(
                  child: Text('Please select a class to view performance data.', style: TextStyle(fontSize: 16)),
                ),
              )
            else ...[
              Card(
                elevation: 4,
                color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Math Exam - Class $_selectedClass Results', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 250,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 100,
                            barTouchData: BarTouchData(enabled: false),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const titles = ['Mahzil', 'Meerab', 'Malaika', 'Fatima'];
                                    if (value >= 0 && value < titles.length) {
                                      return Text(titles[value.toInt()]);
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                              ),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: [
                              BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 85, color: Colors.blue, width: 20, borderRadius: BorderRadius.circular(4))]),
                              BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 92, color: Colors.green, width: 20, borderRadius: BorderRadius.circular(4))]),
                              BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 78, color: Colors.orange, width: 20, borderRadius: BorderRadius.circular(4))]),
                              BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 65, color: Colors.red, width: 20, borderRadius: BorderRadius.circular(4))]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Expanded(
                child: Center(
                  child: Text('AI Prediction: "Focus on student Fatima. Recent marks show a decline."'),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
