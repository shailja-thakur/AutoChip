module top_module(
    input x,
    input y,
    output z);

    wire gate1_out;
    wire gate2_out;

    // Assuming the first gate is an AND gate
    and gate1(gate1_out, x, y);

    // Assuming the second gate is an OR gate
    or gate2(gate2_out, y, x);

    // Assuming the third gate is an XOR gate
    xor gate3(z, gate1_out, gate2_out);

endmodule
