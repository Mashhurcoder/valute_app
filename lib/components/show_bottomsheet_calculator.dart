import 'package:flutter/material.dart';
import '../domain/param/currency_param.dart';

void showCurrencyCalculator(
    BuildContext context,
    CurrencyParam currency,
    ) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.4),
    elevation: 0,
    builder: (context) => _CurrencyCalculatorBottomSheet(currency: currency),
  );
}

class _CurrencyCalculatorBottomSheet extends StatefulWidget {
  final CurrencyParam currency;

  const _CurrencyCalculatorBottomSheet({required this.currency});

  @override
  State<_CurrencyCalculatorBottomSheet> createState() =>
      _CurrencyCalculatorBottomSheetState();
}

class _CurrencyCalculatorBottomSheetState
    extends State<_CurrencyCalculatorBottomSheet>
    with SingleTickerProviderStateMixin {
  late TextEditingController _fromCurrencyController;
  late TextEditingController _toCurrencyController;
  late AnimationController _animationController;

  static const Color _primaryBlue = Color(0xFF0052CC);
  static const Color _darkGray = Color(0xFF1A1A2E);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _borderColor = Color(0xFFE5E7EB);
  static const Color _successGreen = Color(0xFF2E7D32);

  @override
  void initState() {
    super.initState();
    _fromCurrencyController = TextEditingController(text: "1");
    _toCurrencyController = TextEditingController(
      text: widget.currency.rate.toStringAsFixed(2),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) _animationController.forward();
    });
  }

  @override
  void dispose() {
    _fromCurrencyController.dispose();
    _toCurrencyController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _calculateFromCurrency(String value) {
    final amount = double.tryParse(value) ?? 0;
    _toCurrencyController.text =
        (amount * widget.currency.rate).toStringAsFixed(2);
  }

  void _calculateToCurrency(String value) {
    final amount = double.tryParse(value) ?? 0;
    _fromCurrencyController.text =
        (amount / widget.currency.rate).toStringAsFixed(2);
  }

  void _swapValues() {
    final temp = _fromCurrencyController.text;
    _fromCurrencyController.text = _toCurrencyController.text;
    _toCurrencyController.text = temp;
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDragHandle(),
              const SizedBox(height: 28),
              _buildHeader(),
              const SizedBox(height: 36),
              _buildCurrencyInput(
                controller: _fromCurrencyController,
                label: widget.currency.code,
                onChanged: _calculateFromCurrency,
                icon: Icons.trending_up,
                isFromCurrency: true,
              ),
              const SizedBox(height: 20),
              _buildSwapButton(),
              const SizedBox(height: 20),
              _buildCurrencyInput(
                controller: _toCurrencyController,
                label: "UZS",
                onChanged: _calculateToCurrency,
                icon: Icons.trending_down,
                isFromCurrency: false,
              ),
              const SizedBox(height: 36),
              _buildInfoCard(),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: _borderColor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          widget.currency.name,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: _darkGray,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _primaryBlue.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _primaryBlue.withOpacity(0.15),
              width: 1,
            ),
          ),
          child: Text(
            "1 ${widget.currency.code} = ${widget.currency.rate.toStringAsFixed(4)} UZS",
            style: const TextStyle(
              fontSize: 13,
              color: _primaryBlue,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildSwapButton() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _primaryBlue.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _swapValues,
          backgroundColor: _primaryBlue,
          elevation: 0,
          tooltip: 'Swap currencies',
          shape: const CircleBorder(),
          child: const Icon(Icons.swap_vert_rounded, size: 28),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _successGreen.withOpacity(0.08),
            _successGreen.withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _successGreen.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _successGreen.withOpacity(0.15),
            ),
            child: const Center(
              child: Icon(
                Icons.check_circle_rounded,
                color: _successGreen,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rates Updated',
                  style: TextStyle(
                    fontSize: 12,
                    color: _successGreen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Daily at UTC 00:00',
                  style: TextStyle(
                    fontSize: 11,
                    color: _successGreen.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyInput({
    required TextEditingController controller,
    required String label,
    required Function(String) onChanged,
    required IconData icon,
    required bool isFromCurrency,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isFromCurrency ? "Amount to Convert" : "Result",
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: _darkGray,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType:
            const TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: _darkGray,
              letterSpacing: -0.2,
            ),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                color: _textSecondary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 18, right: 14),
                child: Icon(
                  icon,
                  color: _primaryBlue,
                  size: 22,
                ),
              ),
              prefixIconConstraints: const BoxConstraints(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: _borderColor,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: _borderColor,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: _primaryBlue,
                  width: 2.5,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(
                left: 0,
                right: 18,
                top: 18,
                bottom: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}