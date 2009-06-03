require 'ffi'

module FFI
  def self.alias_type(type,aliased)
    add_typedef(find_type(type),aliased.to_sym)
  end

  alias_type :pointer, :llvm_module_ref
  alias_type :pointer, :llvm_type_ref
  alias_type :pointer, :llvm_type_handler_ref
  alias_type :pointer, :llvm_value_ref
  alias_type :pointer, :llvm_basic_block_ref
  alias_type :pointer, :llvm_builder_ref
  alias_type :pointer, :llvm_module_provider_ref
  alias_type :pointer, :llvm_memory_buffer_ref
  alias_type :pointer, :llvm_pass_manager_ref
end
