module top_module(
    input x,
    input y,
    output z);

    assign z = ~(x ^ y); // XOR x and y, then negate the result

endmodule
