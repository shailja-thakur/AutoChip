module top_module (
    input a,
    input b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);

    assign out_and = a & b;       // AND operation
    assign out_or = a | b;        // OR operation
    assign out_xor = a ^ b;       // XOR operation
    assign out_nand = ~(a & b);   // NAND operation
    assign out_nor = ~(a | b);    // NOR operation
    assign out_xnor = ~(a ^ b);   // XNOR operation
    assign out_anotb = a & ~b;    // AND NOT operation

endmodule
