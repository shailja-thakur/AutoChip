module top_module(
    input x,
    input y,
    output z
);

    wire out1, out2;
    
    // First gate (let's say it's an AND gate)
    and gate1(out1, x, y);
    
    // Second gate (let's say it's an OR gate)
    or gate2(out2, y, x);
    
    // Third gate (let's say it's a NAND gate)
    nand gate3(z, out1, out2);

endmodule
