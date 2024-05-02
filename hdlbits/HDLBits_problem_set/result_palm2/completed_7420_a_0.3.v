module top_module (
    input p1a, p1b, p1c, p1d,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    wire p1n1, p1n2, p1n3, p1n4, p2n1, p2n2, p2n3, p2n4;
    wire p1y1, p1y2, p2y1, p2y2;

    NAND gate1 (p1a, p1b, p1n1);
    NAND gate2 (p1c, p1d, p1n2);
    NAND gate3 (p2a, p2b, p2n3);
    NAND gate4 (p2c, p2d, p2n4);
    NAND gate5 (p1n1, p1n2, p1y1);
    NAND gate6 (p1n3, p1n4, p1y2);
    NAND gate7 (p2n1, p2n2, p2y1);
    NAND gate8 (p2n3, p2n4, p2y2);

    assign p1y = p1y1;
    assign p2y = p2y1;

endmodule