import 'dart:io';

import 'package:coinselect_flutter_ffi/coinselect_flutter_ffi.dart';

Future<void> main() async {
  await RustLib.init();
  final list = <OutputGroup>[];
  final output = OutputGroup(
    value: BigInt.one,
    weight: BigInt.from(50),
    inputCount: BigInt.one,
  );
  list.add(output);
  final opt = CoinSelectionOpt(
    targetValue: BigInt.one,
    targetFeerate: 1.1,
    minAbsoluteFee: BigInt.zero,
    baseWeight: BigInt.zero,
    changeWeight: BigInt.zero,
    changeCost: BigInt.zero,
    avgInputWeight: BigInt.zero,
    avgOutputWeight: BigInt.zero,
    minChangeValue: BigInt.zero,
    excessStrategy: ExcessStrategy.toRecipient,
  );

  final result = await selectCoin(inputs: list, options: opt);
  print(result);
  exit(0);
}
