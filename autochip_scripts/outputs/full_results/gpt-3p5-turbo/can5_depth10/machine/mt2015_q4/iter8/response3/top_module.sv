module top_module(
    input x,
    input y,
    output z
);

    wire a, b;  // intermediate wires

    and a_gate(x, y, a);
    or b_gate(x, y, b);
    xor z_gate(a, b, z);

endmodule
