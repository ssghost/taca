const c = @import("c.zig");
const std = @import("std");

const assert = std.debug.assert;

pub fn main() !void {
    defer std.log.info("Done.", .{});
    // Init
    var engine = c.wasm_engine_new() orelse unreachable;
    defer c.wasm_engine_delete(engine);
    var store = c.wasm_store_new(engine) orelse unreachable;
    defer c.wasm_store_delete(store);
    defer std.log.info("Shutting down ...", .{});
    // var context = c.wasmtime_store_context(store);
    // Load wat and wasm
    const wat = @embedFile("hello.wat");
    var wasm: c.wasm_byte_vec_t = undefined;
    var err = c.wasmtime_wat2wasm(wat, wat.len, &wasm);
    assert(err == null);
    // Compile
    std.log.info("Compiling module ...", .{});
    var module = c.wasm_module_new(store, &wasm) orelse unreachable;
    // defer c.wasm_module_delete(module);
    c.wasm_byte_vec_delete(&wasm);
    // Register
    std.log.info("Creating callback ...", .{});
    var hello_type = c.wasm_functype_new_0_0();
    var hello_func = c.wasm_func_new(store, hello_type, helloCallback);
    c.wasm_functype_delete(hello_type);
    // Instantiate
    std.log.info("Instantiating module ...", .{});
    var externs = [_]?*c.wasm_extern_t{c.wasm_func_as_extern(hello_func)};
    var imports = c.wasm_extern_vec_t{ .size = externs.len, .data = &externs };
    var instance = c.wasm_instance_new(store, module, &imports, null) orelse unreachable;
    c.wasm_func_delete(hello_func);
    // Extract
    std.log.info("Extracting export ...", .{});
    var exports: c.wasm_extern_vec_t = undefined;
    c.wasm_instance_exports(instance, &exports);
    assert(exports.size > 0);
    var run_func = c.wasm_extern_as_func(exports.data[0]) orelse unreachable;
    c.wasm_instance_delete(instance);
    c.wasm_module_delete(module);
    // Call
    std.log.info("Calling export ...", .{});
    var args = c.wasm_val_vec_t{ .size = 0, .data = null };
    var results = c.wasm_val_vec_t{ .size = 0, .data = null };
    var trap = c.wasm_func_call(run_func, &args, &results);
    assert(trap == null);
    c.wasm_extern_vec_delete(&exports);
}

fn helloCallback(
    args: ?*const c.wasm_val_vec_t,
    results: ?*c.wasm_val_vec_t,
) callconv(.C) ?*c.wasm_trap_t {
    std.debug.print("Calling back...\n", .{});
    std.debug.print("> Hello World!\n", .{});
    return null;
}
