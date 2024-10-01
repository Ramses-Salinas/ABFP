import 'package:financial_app/presentation/themes/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/provider/transaction_provider.dart';
import '../themes/app_colors.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final bool obscureText;

  const InputField({
    super.key,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.primary,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColors.textSecondary),
        ),
        filled: true,
        fillColor: AppColors.secondary,
      ),
    );
  }
}


class SearchField extends StatelessWidget {
  final String hintText;

  const SearchField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.customSizeWidth(context, 0.03)),
      child: TextField(
        onChanged: (query) {
          Provider.of<TransactionProvider>(context, listen: false).searchTransactions(query);
        },
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: AppColors.secondary,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textSecondary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
