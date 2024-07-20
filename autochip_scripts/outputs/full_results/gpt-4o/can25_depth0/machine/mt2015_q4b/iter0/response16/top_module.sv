module top_module(
    input x,
    input y,
    output z);

    assign z = ~(x ^ y); // Logical negation of the XOR of x and y

endmodule
