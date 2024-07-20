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
    // Perform the logical AND operation
    assign out_and = a & b;

    // Perform the logical OR operation
    assign out_or = a | b;

    // Perform the logical XOR operation
    assign out_xor = a ^ b;

    // Perform the logical NAND operation
    assign out_nand = ~(a & b);

    // Perform the logical NOR operation
    assign out_nor = ~(a | b);

    // Perform the logical XNOR operation
    assign out_xnor = ~(a ^ b);

    // Perform the logical AND NOT operation
    assign out_anotb = a & (~b);
endmodule
