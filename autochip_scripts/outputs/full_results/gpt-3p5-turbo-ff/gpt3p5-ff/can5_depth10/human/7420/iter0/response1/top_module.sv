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

    // Internal signals
    wire p1a_and_p1b;
    wire p1c_and_p1d;
    wire p2a_and_p2b;
    wire p2c_and_p2d;

    // Intermediate signals for NAND gates
    wire p1a_and_p1b_nand;
    wire p1c_and_p1d_nand;
    wire p2a_and_p2b_nand;
    wire p2c_and_p2d_nand;

    // Connect the inputs to the intermediate signals of the first 4-input NAND gate
    assign p1a_and_p1b = p1a & p1b;
    assign p1c_and_p1d = p1c & p1d;

    // NAND gate 1
    assign p1a_and_p1b_nand = ~(p1a_and_p1b);
    assign p1y = p1a_and_p1b_nand & p1c_and_p1d;

    // Connect the inputs to the intermediate signals of the second 4-input NAND gate
    assign p2a_and_p2b = p2a & p2b;
    assign p2c_and_p2d = p2c & p2d;

    // NAND gate 2
    assign p2a_and_p2b_nand = ~(p2a_and_p2b);
    assign p2y = p2a_and_p2b_nand & p2c_and_p2d;

endmodule
