module top_module(
    input x,
    input y,
    output z);

    wire xor_out;

    // XOR operation between inputs x and y
    assign xor_out = x ^ y;

    // AND operation between the result of XOR and input x
    assign z = xor_out & x;

endmodule
