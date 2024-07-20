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
    
    wire a_and_b;
    wire a_or_b;
    
    // AND gate
    and gate_and(a, b, out_and);
    
    // OR gate
    or gate_or(a, b, out_or);
    
    // XOR gate
    xor gate_xor(a, b, out_xor);
    
    // NAND gate
    nand gate_nand(a, b, out_nand);
    
    // NOR gate
    nor gate_nor(a, b, out_nor);
    
    // XNOR gate
    xnor gate_xnor(a, b, out_xnor);
    
    // AND NOT gate
    and gate_and_not(a, ~b, out_anotb);
    
endmodule
