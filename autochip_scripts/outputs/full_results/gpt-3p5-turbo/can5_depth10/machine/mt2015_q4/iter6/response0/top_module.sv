module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    assign a = x & y;
    assign b = x ^ y;  // Fixed the second gate to use XOR instead of OR
    assign z = a & b;  // Fixed the third gate to use AND instead of OR

endmodule
