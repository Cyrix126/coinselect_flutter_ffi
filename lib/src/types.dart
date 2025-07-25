// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.10.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import 'frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `assert_receiver_is_total_eq`, `assert_receiver_is_total_eq`, `clone`, `clone`, `clone`, `clone`, `cmp`, `eq`, `eq`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `partial_cmp`

/// Options required to compute fees and waste metric.
class CoinSelectionOpt {
  /// The value we need to select.
  final BigInt targetValue;

  /// The target feerate we should try and achieve in sats per weight unit.
  final double targetFeerate;

  /// The long term fee-rate is an estimate of the future transaction fee rate that a wallet might need to pay to spend its UTXOs.
  /// If the current fee rates are less than the long term fee rate, it is optimal to consolidate UTXOs to make the spend.
  /// It affects how the [`WasteMetric`] is computed.
  final double? longTermFeerate;

  /// Lowest possible transaction fee required to get a transaction included in a block
  final BigInt minAbsoluteFee;

  /// Weights of data in transaction other than the list of inputs that would be selected.
  ///
  /// This includes weight of the header, total weight out outputs, weight of fields used
  /// to represent number number of inputs and number outputs, witness etc.,
  final BigInt baseWeight;

  /// Additional weigh added to a transaction when a change output is created.
  /// Used in weight metric computation.
  final BigInt changeWeight;

  /// Total cost associated with creating and later spending a change output in a transaction.
  /// This includes the transaction fees for both the current transaction (where the change is created) and the future transaction (where the change is spent)
  final BigInt changeCost;

  /// Estimate of average weight of an input.
  final BigInt avgInputWeight;

  /// Estimate of average weight of an output.
  final BigInt avgOutputWeight;

  /// The smallest amount of change that is considered acceptable in a transaction given the dust limit
  final BigInt minChangeValue;

  /// Strategy to use the excess value other than fee and target
  final ExcessStrategy excessStrategy;

  const CoinSelectionOpt({
    required this.targetValue,
    required this.targetFeerate,
    this.longTermFeerate,
    required this.minAbsoluteFee,
    required this.baseWeight,
    required this.changeWeight,
    required this.changeCost,
    required this.avgInputWeight,
    required this.avgOutputWeight,
    required this.minChangeValue,
    required this.excessStrategy,
  });

  @override
  int get hashCode =>
      targetValue.hashCode ^
      targetFeerate.hashCode ^
      longTermFeerate.hashCode ^
      minAbsoluteFee.hashCode ^
      baseWeight.hashCode ^
      changeWeight.hashCode ^
      changeCost.hashCode ^
      avgInputWeight.hashCode ^
      avgOutputWeight.hashCode ^
      minChangeValue.hashCode ^
      excessStrategy.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoinSelectionOpt &&
          runtimeType == other.runtimeType &&
          targetValue == other.targetValue &&
          targetFeerate == other.targetFeerate &&
          longTermFeerate == other.longTermFeerate &&
          minAbsoluteFee == other.minAbsoluteFee &&
          baseWeight == other.baseWeight &&
          changeWeight == other.changeWeight &&
          changeCost == other.changeCost &&
          avgInputWeight == other.avgInputWeight &&
          avgOutputWeight == other.avgOutputWeight &&
          minChangeValue == other.minChangeValue &&
          excessStrategy == other.excessStrategy;
}

/// Strategy to decide what to do with the excess amount.
enum ExcessStrategy {
  /// Adds the excess amount to the transaction fee. This increases the fee rate
  /// and may lead to faster confirmation, but wastes the excess amount.
  toFee,

  /// Adds the excess amount to the recipient's output. This avoids creating a change
  /// output and reduces transaction size, but may reveal information about the
  /// wallet's available UTXOs.
  toRecipient,

  /// Creates a change output with the excess amount. This preserves privacy and
  /// allows reuse of the excess amount in future transactions, but increases
  /// transaction size and creates dust UTXOs if the amount is too small.
  toChange,
}

/// Represents an input candidate for Coinselection, either as a single UTXO or a group of UTXOs.
///
/// A [`OutputGroup`] can be a single UTXO or a group that should be spent together.
/// Grouping UTXOs belonging to a single address is privacy preserving than grouping UTXOs belonging to different addresses.
/// In the UTXO model the output of a transaction is used as the input for the new transaction and hence the name [`OutputGroup`]
/// The library user must craft this structure correctly, as incorrect representation can lead to incorrect selection results.
class OutputGroup {
  /// Total value of the UTXO(s) that this `WeightedValue` represents.
  final BigInt value;

  /// Total weight of including these UTXO(s) in the transaction.
  ///
  /// The `txin` fields: `prevout`, `nSequence`, `scriptSigLen`, `scriptSig`, `scriptWitnessLen`,
  /// and `scriptWitness` should all be included.
  final BigInt weight;

  /// The total number of inputs
  final BigInt inputCount;

  /// Specifies the relative creation sequence for this group, used only for FIFO selection.
  ///
  /// Set to `None` if FIFO selection is not required. Sequence numbers are arbitrary indices that denote the relative age of a UTXO group among a set of groups.
  /// To denote the oldest UTXO group, assign it a sequence number of `Some(0)`.
  final int? creationSequence;

  const OutputGroup({
    required this.value,
    required this.weight,
    required this.inputCount,
    this.creationSequence,
  });

  @override
  int get hashCode =>
      value.hashCode ^
      weight.hashCode ^
      inputCount.hashCode ^
      creationSequence.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutputGroup &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          weight == other.weight &&
          inputCount == other.inputCount &&
          creationSequence == other.creationSequence;
}

/// Error Describing failure of a selection attempt, on any subset of inputs.
enum SelectionError {
  insufficientFunds,
  noSolutionFound,
  nonPositiveTarget,
  nonPositiveFeeRate,
  abnormallyHighFeeRate,
  abnormallyHighAmount,
}

/// The result of selection algorithm.
class SelectionOutput {
  /// The selected input indices, refers to the indices of the inputs Slice Reference.
  final Uint64List selectedInputs;

  /// The waste amount, for the above inputs.
  final WasteMetric waste;

  const SelectionOutput({required this.selectedInputs, required this.waste});

  @override
  int get hashCode => selectedInputs.hashCode ^ waste.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectionOutput &&
          runtimeType == other.runtimeType &&
          selectedInputs == other.selectedInputs &&
          waste == other.waste;
}

/// Measures the efficiency of input selection in satoshis, helping evaluate algorithms based on current and long-term fee rates
///
/// WasteMetric strikes a balance between minimizing current transaction fees and overall fees during the wallet's lifetime.
/// In high fee rate environments, selecting fewer inputs reduces transaction fees.
/// In low fee rate environments, selecting more inputs reduces overall fees.
/// It compares various selection algorithms to find the most optimized solution, represented by the lowest [WasteMetric] value.
class WasteMetric {
  final double field0;

  const WasteMetric({required this.field0});

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WasteMetric &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}
