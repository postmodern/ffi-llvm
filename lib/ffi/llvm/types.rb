require 'ffi'

module FFI
  module LLVM
    extend FFI::Library

    typedef :pointer, :llvm_module_ref
    typedef :pointer, :llvm_type_ref
    typedef :pointer, :llvm_type_handler_ref
    typedef :pointer, :llvm_value_ref
    typedef :pointer, :llvm_basic_block_ref
    typedef :pointer, :llvm_builder_ref
    typedef :pointer, :llvm_module_provider_ref
    typedef :pointer, :llvm_memory_buffer_ref

    enum :llvm_attribute, [
      :llvm_zext_attr, 1 << 0,
      :llvm_sext_attr, 1 << 1,
      :llvm_no_return_attr, 1 << 2,
      :llvm_in_reg_attr, 1 << 3,
      :llvm_struct_ret_attr, 1 << 4,
      :llvm_no_unwind_attr, 1 << 5,
      :llvm_no_alias_attr, 1 << 6,
      :llvm_by_val_attr, 1 << 7,
      :llvm_nest_attr, 1 << 8,
      :llvm_read_none_attr, 1 << 9,
      :llvm_read_only_attr, 1 << 10
    ]

    enum :llvm_types, [
      :llvm_void_type,         # type with no size
      :llvm_float_type,        # 32 bit floating point type
      :llvm_double_type,       # 64 bit floating point type
      :llvm_x86_fp80_type,     # 80 bit floating point type (X87)
      :llvm_fp128_type,        # 128 bit floating point type
                               # (112-bit mantissa)
      :llvm_ppc_fp128_type,    # 128 bit floating point type (two 64-bits)
      :llvm_label_type,        # Labels
      :llvm_integer_type,      # Arbitrary bit width integers
      :llvm_function_type,     # Functions
      :llvm_struct_type,       # Structures
      :llvm_array_type,        # Arrays
      :llvm_pointer_type,      # Pointers
      :llvm_opaque_type,       # Opaque: type with unknown structure
      :llvm_vector_type        # SIMD 'packed' format, or other vector type
    ]

    enum :llvm_linkage, [
      :llvm_external_linkage,       # Externally visible function
      :llvm_link_once_linkage,      # Keep one copy of function when
                                    # linking (inline)
      :llvm_weak_linkage,           # Keep one copy of function when
                                    # linking (weak)
      :llvm_appending_linkage,      # Special purpose, only applies to
                                    # global arrays
      :llvm_internal_linkage,       # Rename collisions when linking
                                    # (static functions)
      :llvm_dll_import_linkage,     # Function to be imported from DLL
      :llvm_dll_export_linkage,     # Function to be accessible from DLL
      :llvm_external_weak_linkage,  # ExternalWeak linkage description
      :llvm_ghost_linkage           # Stand-in functions for streaming fns
                                    # from bitcode
    ]

    enum :llvm_visibility, [
      :llvm_default_visibility,     # The GV is visible
      :llvm_hidden_visibility,      # The GV is hidden
      :llvm_protected_visibility    # The GV is protected
    ]

    enum :llvm_call_conv, [
      :llvm_call_conv, 0,
      :llvm_fast_call_conv, 8,
      :llvm_cold_call_conv, 9,
      :llvm_x86_std_call_conv, 64,
      :llvm_x86_fast_call_conv, 65
    ]

    enum :llvm_int_predicates, [
      :llvm_int_eq, 32,            # equal
      :llvm_int_ne,                # not equal
      :llvm_int_ugt,               # unsigned greater than
      :llvm_int_uge,               # unsigned greater or equal
      :llvm_int_ult,               # unsigned less than
      :llvm_int_sgt,               # signed greater than
      :llvm_int_sge,               # signed greater or equal
      :llvm_int_slt,               # signed less than
      :llvm_int_sle                # signed less or equal
    ]

    enum :llvm_real_predicates, [
      :llvm_real_predicate_false,  # Always false (always folded)
      :llvm_real_oeq,              # True if ordered and equal
      :llvm_real_ogt,              # True if ordered and greater than
      :llvm_real_oge,              # True if ordered and greater than or equal
      :llvm_real_olt,              # True if ordered and less than
      :llvm_real_ole,              # True if ordered and less than or equal
      :llvm_real_one,              # True if ordered and operands are unequal
      :llvm_real_ord,              # True if ordered (no nans)
      :llvm_real_uno,              # True if unordered: isnan(X) | isnan(Y)
      :llvm_real_ueq,              # True if unordered or equal
      :llvm_real_ugt,              # True if unordered or greater than
      :llvm_real_uge,              # True if unordered, greater than, or equal
      :llvm_real_ult,              # True if unordered or less than
      :llvm_real_ule,              # True if unordered, less than, or equal
      :llvm_real_une,              # True if unordered or not equal
      :llvm_real_predicate_true,   # Always true (always folded)
    ]

    typedef :pointer, :llvm_pass_manager_ref

    enum :llvm_attribute, [
      :llvm_zext_attr, 1 << 0,
      :llvm_sext_attr, 1 << 1,
      :llvm_no_return_attr, 1 << 2,
      :llvm_in_reg_attr, 1 << 3,
      :llvm_struct_ret_attr, 1 << 4,
      :llvm_no_unwind_attr, 1 << 5,
      :llvm_no_alias_attr, 1 << 6,
      :llvm_by_val_attr, 1 << 7,
      :llvm_nest_attr, 1 << 8,
      :llvm_read_none_attr, 1 << 9,
      :llvm_read_only_attr, 1 << 10
    ]

    enum :llvm_types, [
      :llvm_void_type,         # type with no size
      :llvm_float_type,        # 32 bit floating point type
      :llvm_double_type,       # 64 bit floating point type
      :llvm_x86_fp80_type,     # 80 bit floating point type (X87)
      :llvm_fp128_type,        # 128 bit floating point type
                               # (112-bit mantissa)
      :llvm_ppc_fp128_type,    # 128 bit floating point type (two 64-bits)
      :llvm_label_type,        # Labels
      :llvm_integer_type,      # Arbitrary bit width integers
      :llvm_function_type,     # Functions
      :llvm_struct_type,       # Structures
      :llvm_array_type,        # Arrays
      :llvm_pointer_type,      # Pointers
      :llvm_opaque_type,       # Opaque: type with unknown structure
      :llvm_vector_type        # SIMD 'packed' format, or other vector type
    ]

    enum :llvm_linkage, [
      :llvm_external_linkage,       # Externally visible function
      :llvm_link_once_linkage,      # Keep one copy of function when
                                    # linking (inline)
      :llvm_weak_linkage,           # Keep one copy of function when
                                    # linking (weak)
      :llvm_appending_linkage,      # Special purpose, only applies to
                                    # global arrays
      :llvm_internal_linkage,       # Rename collisions when linking
                                    # (static functions)
      :llvm_dll_import_linkage,     # Function to be imported from DLL
      :llvm_dll_export_linkage,     # Function to be accessible from DLL
      :llvm_external_weak_linkage,  # ExternalWeak linkage description
      :llvm_ghost_linkage           # Stand-in functions for streaming fns
                                    # from bitcode
    ]

    enum :llvm_visibility, [
      :llvm_default_visibility,     # The GV is visible
      :llvm_hidden_visibility,      # The GV is hidden
      :llvm_protected_visibility    # The GV is protected
    ]

    enum :llvm_call_conv, [
      :llvm_call_conv, 0,
      :llvm_fast_call_conv, 8,
      :llvm_cold_call_conv, 9,
      :llvm_x86_std_call_conv, 64,
      :llvm_x86_fast_call_conv, 65
    ]

    enum :llvm_int_predicates, [
      :llvm_int_eq, 32,            # equal
      :llvm_int_ne,                # not equal
      :llvm_int_ugt,               # unsigned greater than
      :llvm_int_uge,               # unsigned greater or equal
      :llvm_int_ult,               # unsigned less than
      :llvm_int_sgt,               # signed greater than
      :llvm_int_sge,               # signed greater or equal
      :llvm_int_slt,               # signed less than
      :llvm_int_sle                # signed less or equal
    ]

    enum :llvm_real_predicates, [
      :llvm_real_predicate_false,  # Always false (always folded)
      :llvm_real_oeq,              # True if ordered and equal
      :llvm_real_ogt,              # True if ordered and greater than
      :llvm_real_oge,              # True if ordered and greater than or equal
      :llvm_real_olt,              # True if ordered and less than
      :llvm_real_ole,              # True if ordered and less than or equal
      :llvm_real_one,              # True if ordered and operands are unequal
      :llvm_real_ord,              # True if ordered (no nans)
      :llvm_real_uno,              # True if unordered: isnan(X) | isnan(Y)
      :llvm_real_ueq,              # True if unordered or equal
      :llvm_real_ugt,              # True if unordered or greater than
      :llvm_real_uge,              # True if unordered, greater than, or equal
      :llvm_real_ult,              # True if unordered or less than
      :llvm_real_ule,              # True if unordered, less than, or equal
      :llvm_real_une,              # True if unordered or not equal
      :llvm_real_predicate_true,   # Always true (always folded)
    ]
  end
end
