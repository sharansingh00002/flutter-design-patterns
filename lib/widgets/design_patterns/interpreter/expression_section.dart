import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/interpreter/expression_context.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_button.dart';

class ExpressionSection extends StatefulWidget {
  final ExpressionContext expressionContext;
  final String postfixExpression;

  const ExpressionSection({
    @required this.expressionContext,
    @required this.postfixExpression,
  })  : assert(expressionContext != null),
        assert(postfixExpression != null);

  @override
  _ExpressionSectionState createState() => _ExpressionSectionState();
}

class _ExpressionSectionState extends State<ExpressionSection> {
  final List<String> _solutionSteps = List<String>();

  void _solvePrefixExpression() {
    var solutionSteps = widget.expressionContext
        .solvePostfixExpression(widget.postfixExpression);

    setState(() {
      _solutionSteps.addAll(solutionSteps);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.postfixExpression,
          style: Theme.of(context).textTheme.title,
        ),
        const SizedBox(height: spaceM),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          firstChild: PlatformButton(
            child: Text('Solve'),
            materialColor: Colors.black,
            materialTextColor: Colors.white,
            onPressed: _solvePrefixExpression,
          ),
          secondChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var solutionStep in _solutionSteps)
                Text(
                  solutionStep,
                  style: Theme.of(context).textTheme.subtitle,
                )
            ],
          ),
          crossFadeState: _solutionSteps.isEmpty
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
        const SizedBox(height: spaceXL),
      ],
    );
  }
}
