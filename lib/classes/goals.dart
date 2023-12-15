class FinancialGoal {
  final String title;
  final bool isSelected;

  FinancialGoal({
    required this.title,
    required this.isSelected,
  });

  FinancialGoal copyWith({
    bool? isSelected,
  }) {
    return FinancialGoal(
      title: this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

