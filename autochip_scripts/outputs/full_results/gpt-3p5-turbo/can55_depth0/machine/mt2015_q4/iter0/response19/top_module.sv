module top_module(
    input x,
    input y,
    output z
);

wire a1, b1, a2, b2; // intermediate wires

and gate1(a1, y, x); // first gate
and gate2(b1, x, y); // second gate
and gate3(z, a1, b1); // third gate

endmodule
