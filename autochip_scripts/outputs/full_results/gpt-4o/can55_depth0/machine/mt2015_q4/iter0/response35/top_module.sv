module top_module(
    input x,
    input y,
    output z);
    
    wire out1, out2;
    
    // Instantiate the first AND gate
    and and_gate1 (out1, x, y);
    
    // Instantiate the second OR gate
    or or_gate1 (out2, y, x);
    
    // Instantiate the third NAND gate
    nand nand_gate1 (z, out1, out2);
    
endmodule
