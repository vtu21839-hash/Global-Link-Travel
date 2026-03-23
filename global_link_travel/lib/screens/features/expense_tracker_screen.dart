import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../utils/constants.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({super.key});

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  final double _budget = 50000;
  double _totalSpent = 18500;

  final List<Map<String, dynamic>> _expenses = [
    {'category': 'Transport', 'amount': 5500, 'icon': Icons.directions_car, 'color': Color(0xFF6C5CE7), 'date': 'Mar 20'},
    {'category': 'Hotel', 'amount': 8000, 'icon': Icons.hotel, 'color': Color(0xFF00CEC9), 'date': 'Mar 20'},
    {'category': 'Food', 'amount': 2500, 'icon': Icons.restaurant, 'color': Color(0xFFE17055), 'date': 'Mar 21'},
    {'category': 'Activities', 'amount': 1500, 'icon': Icons.local_activity, 'color': Color(0xFFFDCB6E), 'date': 'Mar 21'},
    {'category': 'Shopping', 'amount': 1000, 'icon': Icons.shopping_bag, 'color': Color(0xFFFF6B6B), 'date': 'Mar 22'},
  ];

  final List<Map<String, dynamic>> _splits = [
    {'name': 'Priya Patel', 'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100', 'owes': 2500, 'status': 'pending'},
    {'name': 'Amit Kumar', 'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100', 'owes': 0, 'status': 'settled'},
    {'name': 'Sneha Reddy', 'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100', 'owes': 1800, 'status': 'pending'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () => _showAddExpenseSheet(), icon: const Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBudgetCard().animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 20),
            _buildCategoryBreakdown().animate().fadeIn(delay: 100.ms, duration: 400.ms),
            const SizedBox(height: 20),
            _buildExpenseSplit().animate().fadeIn(delay: 150.ms, duration: 400.ms),
            const SizedBox(height: 20),
            _buildRecentExpenses().animate().fadeIn(delay: 200.ms, duration: 400.ms),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddExpenseSheet(),
        icon: const Icon(Icons.add),
        label: const Text('Add Expense'),
      ),
    );
  }

  Widget _buildBudgetCard() {
    final remaining = _budget - _totalSpent;
    final percent = _totalSpent / _budget;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Trip Budget', style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Goa Trip', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '₹${NumberFormat('#,##0').format(remaining)}',
            style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text('remaining of ₹${NumberFormat('#,##0').format(_budget)}', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation(percent > 0.8 ? AppColors.error : Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text('${(percent * 100).toInt()}% spent', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Spending by Category', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          ..._expenses.map((exp) {
            final percent = (exp['amount'] as int) / _totalSpent;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (exp['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(exp['icon'] as IconData, color: exp['color'] as Color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(exp['category'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                            Text('₹${NumberFormat('#,##0').format(exp['amount'])}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: percent,
                            minHeight: 6,
                            backgroundColor: AppColors.border,
                            valueColor: AlwaysStoppedAnimation(exp['color'] as Color),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildExpenseSplit() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Split Expenses', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('3 members', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
            ],
          ),
          const SizedBox(height: 14),
          ..._splits.map((split) {
            final isSettled = split['status'] == 'settled';
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSettled ? AppColors.success.withOpacity(0.05) : AppColors.warning.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(split['avatar'] as String),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(split['name'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                        Text(
                          isSettled ? 'Settled up' : '₹${NumberFormat('#,##0').format(split['owes'])} pending',
                          style: GoogleFonts.poppins(fontSize: 12, color: isSettled ? AppColors.success : AppColors.warning),
                        ),
                      ],
                    ),
                  ),
                  if (!isSettled)
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Remind', style: TextStyle(fontSize: 12)),
                    )
                  else
                    Icon(Icons.check_circle, color: AppColors.success, size: 28),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRecentExpenses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Expenses', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ..._expenses.map((exp) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (exp['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(exp['icon'] as IconData, color: exp['color'] as Color),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(exp['category'] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                        Text(exp['date'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textLight)),
                      ],
                    ),
                  ),
                  Text(
                    '-₹${NumberFormat('#,##0').format(exp['amount'])}',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.error),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  void _showAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 16),
            Text('Add Expense', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixText: '₹ ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              children: ['Transport', 'Hotel', 'Food', 'Activities', 'Shopping'].map((cat) {
                return ChoiceChip(
                  label: Text(cat),
                  selected: false,
                  onSelected: (_) {},
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Add Expense'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
