module top_module(
    input x,
    input y,
    output z
);

    assign z = x ^ y; // XOR of x and y
    assign z = x & (x ^ y); // AND of x and the XOR of x and y

endmodule
