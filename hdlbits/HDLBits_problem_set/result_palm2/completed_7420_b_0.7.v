module top_module (
    input p1a, p1b, p1c, p1d,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y
);

    wire p11, p12, p13, p14, p21, p22, p23, p24;

    NAND gate1 (p11, p1a, p1b, p1c);
    NAND gate2 (p12, p1a, p1b, p1d);
    NAND gate3 (p13, p1c, p1d, p1a);
    NAND gate4 (p14, p1c, p1d, p1b);
    NAND gate5 (p21, p2a, p2b, p2c);
    NAND gate6 (p22, p2a, p2b, p2d);
    NAND gate7 (p23, p2c, p2d, p2a);
    NAND gate8 (p24, p2c, p2d, p2b);

    assign p1y = p11 & p12 & p13 & p14;
    assign p2y = p21 & p22 & p23 & p24;

endmodule