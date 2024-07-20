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

    /* Logical AND Operation */
    assign out_and = a && b;

    /* Logical OR Operation */
    assign out_or = a || b;

    /* Logical XOR Operation */
    assign out_xor = a ^ b;

    /* Logical NAND Operation */
    assign out_nand = ~(a && b);

    /* Logical NOR Operation */
    assign out_nor = ~(a || b);

    /* Logical XNOR Operation */
    assign out_xnor = ~(a ^ b);

    /* Logical AND NOT Operation */
    assign out_anotb = a && !b;

endmodule
