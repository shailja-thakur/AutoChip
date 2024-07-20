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

    // Logical AND operation
    assign out_and = a & b;
    
    // Logical OR operation
    assign out_or = a | b;
    
    // Logical XOR operation
    assign out_xor = a ^ b;
    
    // Logical NAND operation
    assign out_nand = ~(a & b);
    
    // Logical NOR operation
    assign out_nor = ~(a | b);
    
    // Logical XNOR operation
    assign out_xnor = ~(a ^ b);
    
    // Logical A AND NOT B operation
    assign out_anotb = a & ~b;

endmodule
