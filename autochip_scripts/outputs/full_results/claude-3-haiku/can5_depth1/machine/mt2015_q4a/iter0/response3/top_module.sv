module top_module(
    input x,
    input y,
    output z);

    wire xor_xy;
    assign xor_xy = x ^ y;
    assign z = xor_xy & x;

endmodule
