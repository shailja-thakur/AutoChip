module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);

    wire nand1_out;
    wire nand2_out;

    nand_gate nand1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(nand1_out));
    nand_gate nand2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(nand2_out));

    // 2-input NAND gate
    nand_gate nand_gate(
        input a,
        input b,
        output y
    );

    // NAND gate implementation
    assign nand_gate.in_a = a;
    assign nand_gate.in_b = b;
    assign nand_gate.out_y = ~(a & b);

    // Connect 4-input NAND gates to outputs
    assign p1y = nand1_out;
    assign p2y = nand2_out;

endmodule
