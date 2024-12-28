import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProgressCharts extends StatelessWidget {
  final List<QueryDocumentSnapshot> sessions;
  final int selectedPeriod;

  const ProgressCharts({
    Key? key,
    required this.sessions,
    required this.selectedPeriod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDurationChart(),
        const SizedBox(height: 12),
        _buildCategoryDistribution(),
      ],
    );
  }

  Widget _buildDurationChart() {
    final Map<String, int> dailyDurations = {};
    final now = DateTime.now();

    // Initialiser tous les jours avec 0
    for (int i = selectedPeriod - 1; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateStr = DateFormat('dd/MM').format(date);
      dailyDurations[dateStr] = 0;
    }

    // Remplir avec les données réelles
    for (var session in sessions) {
      final data = session.data() as Map<String, dynamic>;
      final date = (data['date'] as Timestamp).toDate();
      final dateStr = DateFormat('dd/MM').format(date);
      final duration = int.parse(data['duration'].toString());
      dailyDurations[dateStr] = (dailyDurations[dateStr] ?? 0) + duration;
    }

    final spots = dailyDurations.entries.map((entry) {
      final index = dailyDurations.keys.toList().indexOf(entry.key);
      return FlSpot(index.toDouble(), entry.value.toDouble());
    }).toList();

    return Container(
      height: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Durée des séances',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value % 5 == 0 && value < dailyDurations.length) {
                          return Text(
                            dailyDurations.keys.elementAt(value.toInt()),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.purple.shade700,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.purple.shade700.withOpacity(0.1),
                    ),
                  ),
                ],
                minX: 0,
                maxX: (dailyDurations.length - 1).toDouble(),
                minY: 0,
                maxY: (dailyDurations.values.isEmpty
                        ? 60
                        : dailyDurations.values.reduce((a, b) => a > b ? a : b)) *
                    1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDistribution() {
    final Map<String, int> categoryCount = {};
    final Map<String, Color> categoryColors = {
      'débutant': Colors.green,
      'intermédiaire': Colors.blue,
      'avancé': Colors.purple,
      'méditation': Colors.deepPurple,
      'matinal': Colors.orange,
      'prénatal': Colors.pink,
    };

    for (var session in sessions) {
      final data = session.data() as Map<String, dynamic>;
      final category = data['category'] as String;
      categoryCount[category] = (categoryCount[category] ?? 0) + 1;
    }

    final total = categoryCount.values.fold(0, (sum, count) => sum + count);

    return Container(
      height: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Distribution par catégorie',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 1,
                      centerSpaceRadius: 25,
                      sections: categoryCount.entries.map((entry) {
                        final percentage = (entry.value / total) * 100;
                        return PieChartSectionData(
                          color: categoryColors[entry.key] ?? Colors.grey,
                          value: entry.value.toDouble(),
                          title: '${percentage.toStringAsFixed(0)}%',
                          radius: 40,
                          titleStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categoryCount.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: categoryColors[entry.key] ?? Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${entry.value}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
