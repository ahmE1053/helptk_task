import 'dart:ui';

Offset calculate(Path path, double value) {
  PathMetrics pathMetrics = path.computeMetrics();
  PathMetric pathMetric = pathMetrics.elementAt(0);
  value = pathMetric.length * value;
  Tangent pos = pathMetric.getTangentForOffset(value)!;
  return pos.position;
}
