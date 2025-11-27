import 'package:flutter/material.dart';
import 'bmi_controller.dart';

class BmiPage extends StatefulWidget {
  final BmiController controller;
  const BmiPage({super.key, required this.controller});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  late BmiController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = widget.controller;
    ctrl.addListener(_onChange);
  }

  @override
  void dispose() {
    ctrl.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final preview = ctrl.preview();
    final last = ctrl.lastResult;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final isWide = constraints.maxWidth > 700;
        final horizontalPadding = isWide ? 48.0 : 16.0;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 40),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: isWide
                          ? Row(
                              children: [
                                Expanded(child: _buildControls(theme)),
                                const SizedBox(width: 20),
                                Expanded(child: _buildPreviewCard(preview, last, theme)),
                              ],
                            )
                          : Column(
                              children: [
                                _buildControls(theme),
                                const SizedBox(height: 16),
                                _buildPreviewCard(preview, last, theme),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: ctrl.reset,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text('Reset'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: ctrl.calculate,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text('Calculate'),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                 
                  if (last != null) ...[
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Result', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(last.value.toString(), style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(last.category, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 6),
                                    SizedBox(
                                      width: isWide ? 400 : 200,
                                      child: Text(last.interpretation, textAlign: TextAlign.right),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildControls(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Height (cm)', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text('${ctrl.height.toStringAsFixed(0)} cm', textAlign: TextAlign.right, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        Slider(
          value: ctrl.height,
          min: 100,
          max: 220,
          divisions: 120,
          label: '${ctrl.height.toStringAsFixed(0)}',
          onChanged: (v) => ctrl.updateHeight(v),
        ),

        const SizedBox(height: 12),

        const Text('Weight (kg)', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text('${ctrl.weight.toStringAsFixed(0)} kg', textAlign: TextAlign.right, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        Slider(
          value: ctrl.weight,
          min: 30,
          max: 200,
          divisions: 170,
          label: '${ctrl.weight.toStringAsFixed(0)}',
          onChanged: (v) => ctrl.updateWeight(v),
        ),
      ],
    );
  }

  Widget _buildPreviewCard(BmiResult? preview, BmiResult? last, ThemeData theme) {
    final p = preview;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Preview', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            if (p != null) ...[
              Text(p.value.toString(), style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(p.category, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(p.interpretation),
            ] else
              const Text('Enter height and weight to preview'),

            const SizedBox(height: 12),

            const Divider(),
            const SizedBox(height: 8),
            Text('Last computed: ${last?.value ?? '-'}', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
