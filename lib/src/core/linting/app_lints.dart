// Conjunto personalizado de reglas de linting para el proyecto Flutter
// basado en flutter_lints, very_good_analysis y dart_code_metrics.
// Define reglas adicionales y ajusta severidades para CI/CD.

import 'package:flutter_lints/flutter_lints.dart' as flutter_lints;
import 'package:very_good_analysis/very_good_analysis.dart' as very_good;

final List<String> _excludedPatterns = [
  r'.g.dart$',
  r'.freezed.dart$',
  r'test/.+',
];

const _customRules = {
  // Reglas adicionales de very_good_analysis
  'always_put_control_body_on_new_line': true,
  'avoid_bool_literals_in_conditional_expressions': true,
  'avoid_catches_without_on_clauses': true,
  'avoid_catching_errors': true,
  'avoid_double_and_int_checks': true,
  'avoid_equals_and_hash_code_on_mutable_classes': true,
  'avoid_escaping_inner_quotes': true,
  'avoid_field_initializers_in_const_classes': true,
  'avoid_final_parameters': true,
  'avoid_implementing_value_types': true,
  'avoid_js_rounded_ints': true,
  'avoid_multiple_declarations_per_line': true,
  'avoid_positional_boolean_parameters': true,
  'avoid_private_typedef_functions': true,
  'avoid_redundant_argument_values': true,
  'avoid_returning_this': true,
  'avoid_setters_without_getters': true,
  'avoid_types_on_closure_parameters': true,
  'avoid_unused_constructor_parameters': true,
  'avoid_void_async': true,
  'cascade_invocations': true,
  'cast_nullable_to_non_nullable': true,
  'conditional_uri_does_not_exist': true,
  'deprecated_consistency': true,
  'do_not_use_environment': true,
  'eol_at_end_of_file': true,
  'join_return_with_assignment': true,
  'leading_newlines_in_multiline_strings': true,
  'missing_whitespace_between_adjacent_strings': true,
  'no_default_cases': true,
  'no_literal_bool_comparisons': true,
  'no_runtimeType_toString': true,
  'noop_primitive_operations': true,
  'omit_local_variable_types': true,
  'only_throw_errors': true,
  'parameter_assignments': true,
  'prefer_asserts_in_initializer_lists': true,
  'prefer_asserts_with_message': true,
  'prefer_constructors_over_static_methods': true,
  'prefer_final_in_for_each': true,
  'prefer_final_locals': true,
  'prefer_if_elements_to_conditional_expressions': true,
  'prefer_int_literals': true,
  'prefer_mixin': true,
  'prefer_null_aware_method_calls': true,
  'prefer_null_aware_operators': true,
  'prefer_relative_imports': true,
  'prefer_single_quotes': true,
  'prefer_spread_collections': true,
  'sort_child_properties_last': true,
  'sort_constructors_first': true,
  'sort_unnamed_constructors_first': true,
  'test_types_in_equals': true,
  'throw_in_finally': true,
  'tighten_type_of_initializing_formals': true,
  'type_annotate_public_apis': true,
  'unawaited_futures': true,
  'unnecessary_await_in_return': true,
  'unnecessary_lambdas': true,
  'unnecessary_null_aware_assignments': true,
  'unnecessary_null_aware_operator_on_extension_on_nullable': true,
  'unnecessary_null_checks': true,
  'unnecessary_nullable_for_final_variable_declarations': true,
  'unnecessary_overrides': true,
  'unnecessary_parenthesis': true,
  'unnecessary_raw_strings': true,
  'unnecessary_statements': true,
  'unnecessary_to_list_in_spreads': true,
  'use_colored_box': true,
  'use_decorated_box': true,
  'use_if_null_to_convert_nulls_to_bools': true,
  'use_is_even_rather_than_modulo': true,
  'use_named_constants': true,
  'use_raw_strings': true,
  'use_setters_to_change_properties': true,
  'use_string_buffers': true,
  'use_string_in_part_of_directives': true,
  'use_test_throws_matchers': true,
  'use_to_and_as_if_applicable': true,

  // Reglas específicas de dart_code_metrics
  'avoid-unused-parameters': 'error',
  'avoid-nested-conditional-expressions': 'error',
  'avoid-missing-enum-constant-in-map': 'error',
  'binary-expression-operand-order': 'warning',
  'double-literal-format': 'warning',
  'no-boolean-literal-compare': 'warning',
  'no-empty-block': 'warning',
  'prefer-conditional-expressions': 'warning',
  'prefer-intl-name': 'warning',
  'prefer-match-file-name': 'warning',
  'avoid-global-state': 'error',
  'avoid-shadowing': 'warning',
  'avoid-unnecessary-type-casts': 'warning',
  'avoid-unnecessary-type-assertions': 'warning',
  'avoid-unrelated-type-assertions': 'error',
  'avoid-unused-generics': 'error',
  'avoid-dynamic': 'warning',
  'avoid-passing-async-when-sync-expected': 'error',
  'avoid-redundant-async': 'warning',
  'avoid-unnecessary-setstate': 'warning',
  'avoid-late-keyword': 'warning',
  'prefer-first': 'warning',
  'prefer-last': 'warning',
  'prefer-correct-edge-insets-constructor': 'warning',
  'prefer-single-widget-per-file': 'warning',
  'prefer-extracting-callbacks': 'warning',
  'avoid-duplicate-exports': 'error',
  'avoid-returning-widgets': 'warning',
  'prefer-text-rich': 'warning',
  'prefer-const-border-radius': 'warning',
  'prefer-correct-type-name': 'warning',
  'prefer-correct-test-file-name': 'warning',
};

Map<String, Object> _createAnalysisOptions() {
  return {
    'analyzer': {
      'errors': {
        'unused_local_variable': 'warning',
        'unused_import': 'error',
        'invalid_annotation_target': 'ignore',
      },
      'exclude': _excludedPatterns,
      'plugins': ['dart_code_metrics'],
    },
    'linter': {
      'rules': [
        ...flutter_lints.recommended.map((r) => r.toString()),
        ...very_good.recommended.map((r) => r.toString()),
        for (final rule in _customRules.entries)
          if (rule.value is bool && rule.value as bool)
            rule.key,
          if (rule.value is String)
            {'$rule.key': {'severity': rule.value}},
      ],
    },
    'dart_code_metrics': {
      'anti-patterns': [
        {'long-method': null},
        {'long-parameter-list': null},
      ],
      'metrics': {
        'cyclomatic-complexity': 10,
        'maximum-nesting-level': 4,
        'number-of-parameters': 4,
        'source-lines-of-code': 50,
      },
      'metrics-exclude': _excludedPatterns,
      'rules': [
        for (final rule in _customRules.entries)
          if (rule.value is String && rule.key.startsWith('avoid-') || rule.key.startsWith('prefer-'))
            {'$rule.key': {'severity': rule.value}},
      ],
    },
  };
}

final Map<String, Object> appLints = _createAnalysisOptions();