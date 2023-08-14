module top_module( 
    input a, b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);

    // Create the logic gates
    AND gate_and (a, b, out_and);
    OR gate_or (a, b, out_or);
    XOR gate_xor (a, b, out_xor);
    NAND gate_nand (a, b, out_nand);
    NOR gate_nor (a, b, out_nor);
    XNOR gate_xnor (a, b, out_xnor);
    AND gate_anotb (a, !b, out_anotb);

endmodule