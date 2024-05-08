module top_module (
    input p1a, p1b, p1c, p1d,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    wire p1n1, p1n2, p1n3, p1n4, p2n1, p2n2, p2n3, p2n4;
    
    NAND gate1 (p1n1, p1a, p1b);
    NAND gate2 (p1n2, p1c, p1d);
    NAND gate3 (p1n3, p1n1, p1n2);
    NAND gate4 (p1n4, p2a, p2b);
    NAND gate5 (p2n1, p2c, p2d);
    NAND gate6 (p2n2, p1n3, p1n4);
    NAND gate7 (p2n3, p2n1, p2n2);
    NAND gate8 (p2n4, p1n1, p1n2);

    assign p1y = p1n3;
    assign p2y = p2n3;

endmodule