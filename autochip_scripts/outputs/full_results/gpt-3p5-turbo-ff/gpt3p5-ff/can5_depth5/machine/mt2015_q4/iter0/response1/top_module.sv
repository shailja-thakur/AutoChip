module top_module(
    input x,
    input y,
    output z);

    wire a, b;
    wire gate1_output;
    wire gate2_output;

    // Logic gates
    and gate1(a, b, gate1_output);
    xor gate2(x, y, gate2_output);
    or gate3(gate1_output, gate2_output, z);

endmodule
