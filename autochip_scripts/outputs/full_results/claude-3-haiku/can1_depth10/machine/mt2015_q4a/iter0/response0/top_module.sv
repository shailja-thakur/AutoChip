module top_module(
    input x,
    input y,
    output z
);

    wire xor_out;
    assign xor_out = x ^ y;
    assign z = xor_out & x;

endmodule
