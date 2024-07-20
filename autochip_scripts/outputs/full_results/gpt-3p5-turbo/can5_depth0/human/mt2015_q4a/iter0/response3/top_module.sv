module top_module(
    input x,
    input y,
    output z);

    // intermediate wire for the XOR operation
    wire xor_result;

    // XOR gate
    assign xor_result = x ^ y;

    // AND gate
    assign z = xor_result & x;

endmodule
