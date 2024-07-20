module top_module(
    input x,
    input y,
    output z);

    // Intermediate wire for XOR of x and y
    wire xor_xy;

    // XOR gate 
    assign xor_xy = x ^ y;

    // AND gate to produce final output
    assign z = xor_xy & x;

endmodule
