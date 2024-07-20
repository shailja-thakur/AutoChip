module top_module(
    input x,
    input y,
    output z);

    wire xor_xy;  // Wire for the XOR result

    assign xor_xy = x ^ y;  // XOR operation
    assign z = xor_xy & x;  // AND operation with the first input x

endmodule
