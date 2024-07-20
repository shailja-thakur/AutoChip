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

    wire nand_1, nand_2;

    nand gate_1 (p1a, p1b, p1c, p1d, nand_1);
    nand gate_2 (p2a, p2b, p2c, p2d, nand_2);

    assign p1y = nand_1;
    assign p2y = nand_2;

    // 4-input NAND gate
    module nand (
        input a,
        input b,
        input c,
        input d,
        output y
    );
    
        assign y = ~(a & b & c & d);

    endmodule
