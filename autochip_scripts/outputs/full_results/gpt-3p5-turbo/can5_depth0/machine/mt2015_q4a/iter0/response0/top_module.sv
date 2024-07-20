module top_module(
    input x,
    input y,
    output z);

    xor #(1) xor_gate(x, y, x_xor_y);
    and #(1) and_gate(x_xor_y, x, z);

endmodule
