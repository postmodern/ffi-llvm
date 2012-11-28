require 'rubygems'
require 'ffi'

require 'llvm/typedefs'

module FFI
  module LLVM
    extend FFI::Library

    ffi_lib 'libLLVMCore.so'

    enum :llvm_attribute, {
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
    }

    enum :llvm_types, {
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
    }

    enum :llvm_linkage, {
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
    }

    enum :llvm_visibility, {
      :llvm_default_visibility,     # The GV is visible
      :llvm_hidden_visibility,      # The GV is hidden
      :llvm_protected_visibility    # The GV is protected
    }

    enum :llvm_call_conv, {
      :llvm_call_conv, 0,
      :llvm_fast_call_conv, 8,
      :llvm_cold_call_conv, 9,
      :llvm_x86_std_call_conv, 64,
      :llvm_x86_fast_call_conv, 65
    }

    enum :llvm_int_predicates, {
      :llvm_int_eq, 32,            # equal
      :llvm_int_ne,                # not equal
      :llvm_int_ugt,               # unsigned greater than
      :llvm_int_uge,               # unsigned greater or equal
      :llvm_int_ult,               # unsigned less than
      :llvm_int_sgt,               # signed greater than
      :llvm_int_sge,               # signed greater or equal
      :llvm_int_slt,               # signed less than
      :llvm_int_sle                # signed less or equal
    }

    enum :llvm_real_predicates, {
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
    }

    attach_function :"LLVMDisposeMessage", [:pointer], :void

    attach_function :"LLVMModuleCreateWithName", [:string], :llvm_module_ref
    attach_function :"LLVMDisposeModel", [:llvm_module_ref], :void

    attach_function :"LLVMGetDataLayout", [:llvm_module_ref], :string
    attach_function :"LLVMSetDataLayout", [:llvm_module_ref, :string], :void

    attach_function :"LLVMGetTarget", [:llvm_module_ref], :string
    attach_function :"LLVMSetTarget", [:llvm_module_ref, :string], :void

    attach_function :"LLVMAddTypeName", [:llvm_module_ref, :string, :llvm_type_ref], :int
    attach_function :"LLVMDeleteTypeName", [:llvm_module_ref, :string], :void

    attach_function :"LLVMDumpModule", [:llvm_module_ref], :void

    # Operations on integer types
    attach_function :"LLVMGetTypeKind", [:llvm_type_ref], :llvm_types
    attach_function :"LLVMInt1Type", [], :llvm_type_ref
    attach_function :"LLVMInt8Type", [], :llvm_type_ref
    attach_function :"LLVMInt16Type", [], :llvm_type_ref
    attach_function :"LLVMInt32Type", [], :llvm_type_ref
    attach_function :"LLVMInt64Type", [], :llvm_type_ref
    attach_function :"LLVMIntType", [], :llvm_type_ref
    attach_function :"LLVMIntTypeWidth", [:llvm_type_ref], :uint

    # Operations on real types
    attach_function :"LLVMFloatType", [], :llvm_type_ref
    attach_function :"LLVMDoubleType", [], :llvm_type_ref
    attach_function :"LLVMX86FP80Type", [], :llvm_type_ref
    attach_function :"LLVMFP128Type", [], :llvm_type_ref
    attach_function :"LLVMPPCFP128Type", [], :llvm_type_ref

    # Operations on function types
    attach_function :"LLVMFunctionType", [:llvm_type_ref, :pointer, :uint, :int], :llvm_type_ref
    attach_function :"LLVMIsFunctionVarArg", [:llvm_type_ref], :int
    attach_function :"LLVMGetReturnType", [:llvm_type_ref], :llvm_type_ref
    attach_function :"LLVMCountParamTypes", [:llvm_type_ref], :uint
    attach_function :"LLVMGetParamTypes", [:llvm_type_ref, :pointer], :void

    # Operations on struct types
    attach_function :"LLVMStructType", [:pointer, :uint, :int], :llvm_type_ref
    attach_function :"LLVMCountStructElementTypes", [:llvm_type_ref], :uint
    attach_function :"LLVMGetStructElementTypes", [:llvm_type_ref, :pointer], :void
    attach_function :"LLVMIsPackedStruct", [:llvm_type_ref], :int

    # Operations on array, pointer, and vector types (sequence types)
    attach_function :"LLVMArrayType", [:llvm_type_ref, :uint], :llvm_type_ref
    attach_function :"LLVMPointerType", [:llvm_type_ref, :uint], :llvm_type_ref
    attach_function :"LLVMVectorType", [:llvm_type_ref, :uint], :llvm_type_ref

    attach_function :"LLVMGetElementType", [:llvm_type_ref], :llvm_type_ref
    attach_function :"LLVMGetArrayLength", [:llvm_type_ref], :uint
    attach_function :"LLVMGetPointerAddressSpace", [:llvm_type_ref], :uint
    attach_function :"LLVMGetVectorSize", [:llvm_type_ref], :uint

    # Operations on other types
    attach_function :"LLVMVoidType", [], :llvm_type_ref
    attach_function :"LLVMLabelType", [], :llvm_type_ref
    attach_function :"LLVMOpaqueType", [], :llvm_type_ref

    # Operations on type handles
    attach_function :"LLVMCreateTypeHandle", [:llvm_type_ref], :llvm_type_handle_ref
    attach_function :"LLVMRefineType", [:llvm_type_ref, :llvm_type_ref], :void
    attach_function :"LLVMResolveTypeHandle", [:llvm_type_handle_ref], :llvm_type_ref
    attach_function :"LLVMDisposeTypeHandle", [:llvm_type_handle_ref], :void

    #
    # == Values:
    #
    # The bulk of LLVM's object model consists of values, which comprise a
    # very rich type hierarchy.
    #
    
    attach_function :"LLVMTypeOf", [:llvm_value_ref], :llvm_type_ref
    attach_function :"LLVMGetValueName", [:llvm_value_ref], :string
    attach_function :"LLVMSetValueName", [:llvm_value_ref, :string], :void
    attach_function :"LLVMDumpValue", [:llvm_value_ref], :void

    # Operations on constants of any type
    attach_function :"LLVMConstNull", [:llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstAllOnes", [:llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMGetUndef", [:llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMIsConstant", [:llvm_value_ref], :int
    attach_function :"LLVMIsNull", [:llvm_value_ref], :int
    attach_function :"LLVMIsUndef", [:llvm_value_ref], :int

    # Operations on scalar constants
    attach_function :"LLVMConstInt", [:llvm_type_ref, :ulonglong, :int], :llvm_value_ref
    attach_function :"LLVMConstReal", [:llvm_type_ref, :double], :llvm_value_ref
    attach_function :"LLVMConstRealOfString", [:llvm_type_ref, :string], :llvm_value_ref

    # Operations on composite constants
    attach_function :"LLVMConstString", [:string, :uint, :int], :llvm_value_ref
    attach_function :"LLVMConstArray", [:llvm_type_ref, :pointer, :uint], :llvm_value_ref
    attach_function :"LLVMConstStruct", [:pointer, :uint, :int], :llvm_value_ref
    attach_function :"LLVMConstVector", [:pointer, :uint], :llvm_value_ref

    # Constant expressions
    attach_function :"LLVMSizeOf", [:llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstNeg", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstNot", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstAdd", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstSub", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstMul", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstUDiv", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstSDiv", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstFDiv", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstURem", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstSRem", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstFRem", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstAnd", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstOr", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstXor", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstICmp", [:llvm_value_ref, :llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstFCmp", [:llvm_value_ref, :llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstShl", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstLShr", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstAShr", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstGEP", [:llvm_value_ref, :pointer, :uint], :llvm_value_ref
    attach_function :"LLVMConstTrunc", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstSExt", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstZExt", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstFPTrunc", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstFPExt", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstUIToFP", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstSIToFP", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstFPToUI", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstFPToSI", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstPtrToInt", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstIntToPtr", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstBitCast", [:llvm_value_ref, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMConstSelect", [:llvm_value_ref, :llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstExtractElement", [:llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstInsertElement", [:llvm_value_ref, :llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstShuffleVector", [:llvm_value_ref, :llvm_value_ref, :llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMConstExtractValue", [:llvm_value_ref, :pointer, :uint], :llvm_value_ref
    attach_function :"LLVMConstInsertValue", [:llvm_value_ref, :llvm_value_ref, :pointer, :uint], :llvm_value_ref
    attach_function :"LLVMConstInlineAsm", [:llvm_type_ref, :string, :string, :int], :llvm_value_ref

    # Operations on global variables, functions, and aliases (globals)
    attach_function :"LLVMGetGlobalParent", [:llvm_value_ref], :llvm_module_ref
    attach_function :"LLVMIsDeclaration", [:llvm_value_ref], :int
    attach_function :"LLVMGetLinkage", [:llvm_value_ref], :llvm_linkage
    attach_function :"LLVMSetLinkage", [:llvm_value_ref, :llvm_linkage], :void
    attach_function :"LLVMGetSection", [:llvm_value_ref], :string
    attach_function :"LLVMSetSection", [:llvm_value_ref, :string], :void
    attach_function :"LLVMGetVisibility", [:llvm_value_ref], :llvm_visibility
    attach_function :"LLVMSetVisibility", [:llvm_value_ref, :llvm_visibility], :void
    attach_function :"LLVMGetAlignment", [:llvm_value_ref], :uint
    attach_function :"LLVMSetAlignment", [:llvm_value_ref, :uint], :void

    # Operations on global variables
    attach_function :"LLVMAddGlobal", [:llvm_module_ref, :llvm_type_ref, :string], :llvm_value_ref
    attach_function :"LLVMGetNameGlobal", [:llvm_module_ref, :string], :llvm_value_ref
    attach_function :"LLVMGetFirstGlobal", [:llvm_module_ref], :llvm_value_ref
    attach_function :"LLVMGetLastGlobal", [:llvm_module_ref], :llvm_value_ref
    attach_function :"LLVMGetNextGlobal", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMGetPreviousGlobal", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMDeleteGlobal", [:llvm_value_ref], :void
    attach_function :"LLVM_GetInitializer", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMSetInitializer", [:llvm_value_ref, :llvm_value_ref], :void
    attach_function :"LLVMIsThreadLocal", [:llvm_value_ref], :int
    attach_function :"LLVMSetThreadLocal", [:llvm_value_ref, :int], :void
    attach_function :"LLVMIsGlobalConstant", [:llvm_value_ref], :int
    attach_function :"LLVMSetGlobalConstant", [:llvm_value_ref, :int], :void

    # Operations on aliases
    attach_function :"LLVMAddAlias", [:llvm_module_ref, :llvm_type_ref, :llvm_value_ref, :string], :llvm_value_ref

    # Operations on functions
    attach_function :"LLVMAddFunction", [:llvm_module_ref, :string, :llvm_type_ref], :llvm_value_ref
    attach_function :"LLVMGetNamedFunction", [:llvm_module_ref, :string], :llvm_value_ref
    attach_function :"LLVMGetFirstFunction", [:llvm_module_ref], :llvm_value_ref
    attach_function :"LLVMGetLastFunction", [:llvm_module_ref], :llvm_value_ref
    attach_function :"LLVMGetNextFunction", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMGetPreviousFunction", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMDeleteFunction", [:llvm_value_ref], :void
    attach_function :"LLVMGetInstrinsicID", [:llvm_value_ref], :uint
    attach_function :"LLVMGetFunctionCallConv", [:llvm_value_ref], :uint
    attach_function :"LLVMSetFunctionCallConv", [:llvm_value_ref, :uint], :void
    attach_function :"LLVMGetGC", [:llvm_value_ref], :string
    attach_function :"LLVMSetGC", [:llvm_value_ref, :string], :void

    # Operations on parameters
    attach_function :"LLVMCountParams", [:llvm_value_ref], :uint
    attach_function :"LLVMGetParams", [:llvm_value_ref, :pointer], :void
    attach_function :"LLVMGetParam", [:llvm_value_ref, :uint], :llvm_value_ref
    attach_function :"LLVMGetParamParent", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMGetFirstParam", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMGetLastParam", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMGetNextParam", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMGetPreviousParam", [:llvm_value_ref], :llvm_value_ref
    attach_function :"LLVMAddAttribute", [:llvm_value_ref, :llvm_attribute], :void
    attach_function :"LLVMRemoveAttribute", [:llvm_value_ref, :llvm_attribute], :void
    attach_function :"LLVMSetParamAlignment", [:llvm_value_ref, :uint], :void

    # Operations on basic blocks
    attach_function :"LLVMBasicBlockAsValue", [:llvm_basic_block_ref], :llvm_value_ref
    attach_function :"LLVMValueIsBasicBlock", [:llvm_value_ref], :int
    attach_function :"LLVMValueAsBasicBlock", [:llvm_value_ref], :llvm_basic_block_ref
    attach_function :"LLVMGetBasicBlockParent", [:llvm_basic_block_ref], :llvm_value_ref
    attach_function :"LLVMCountBasicBlocks", [:llvm_value_ref], :uint
  end
end
