module top_module(
    input x,
    input y,
    output z);

    wire gate1_out, gate2_out;

    and gate1(gate1_out, x, y);
    or  gate2(gate2_out, y, x);
    xor gate3(z, gate1_out, gate2_out);

endmodule
