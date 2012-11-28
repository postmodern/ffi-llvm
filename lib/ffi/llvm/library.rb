require 'ffi/llvm/types'

require 'ffi'

module FFI
  module LLVM
    extend FFI::Library

    ffi_lib 'libLLVMCore.so'

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
    # ## Values:
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
