module top_module(
    input x,
    input y,
    output z);

    // Internal wire to hold the result of the XOR operation
    wire xor_result;

    // XOR gate to compute the logical XOR of x and y
    // The result is stored in the xor_result wire
    xor_gate xor1(.a(x), .b(y), .z(xor_result));

    // NOT gate to compute the logical negation of the XOR result
    not_gate not1(.a(xor_result), .z(z));

endmodule
