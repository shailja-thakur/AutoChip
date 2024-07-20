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

    // Logical AND operation between inputs a and b
    assign out_and = a & b;

    // Logical OR operation between inputs a and b
    assign out_or = a | b;

    // Logical XOR operation between inputs a and b
    assign out_xor = a ^ b;

    // Logical NAND operation between inputs a and b
    assign out_nand = ~(a & b);

    // Logical NOR operation between inputs a and b
    assign out_nor = ~(a | b);

    // Logical XNOR operation between inputs a and b
    assign out_xnor = ~(a ^ b);

    // Logical AND NOT operation between inputs a and b
    assign out_anotb = a & ~b;

endmodule
