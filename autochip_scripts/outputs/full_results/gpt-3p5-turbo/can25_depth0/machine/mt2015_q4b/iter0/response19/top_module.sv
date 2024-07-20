module top_module(
    input x,
    input y,
    output z);

    // Declare internal wires
    wire xor_result, or_result;

    // XOR gate
    xor gate_xor ( .a(x), .b(y), .z(xor_result) );

    // OR gate
    or gate_or ( .a(x), .b(y), .z(or_result) );

    // NOT gate
    not gate_not ( .a(or_result), .z(z) );

endmodule
