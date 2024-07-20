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

    assign out_and = a & b;          // Logical AND
    assign out_or = a | b;           // Logical OR
    assign out_xor = a ^ b;          // Logical XOR
    assign out_nand = ~(a & b);      // Logical NAND
    assign out_nor = ~(a | b);       // Logical NOR
    assign out_xnor = ~(a ^ b);      // Logical XNOR
    assign out_anotb = a & ~b;       // Logical AND NOT

endmodule
