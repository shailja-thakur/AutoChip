module top_module(
    input x,
    input y,
    output z);

    // wire for intermediate signals
    wire temp;

    // XOR gate
    assign temp = x ^ y;

    // AND gate
    assign z = temp & x;

endmodule
