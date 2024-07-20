module top_module(
    input x,
    input y,
    output z);
    
    wire out1, out2;
    
    and gate1(out1, x, y); // First gate: AND gate with inputs x and y
    or gate2(out2, x, y);  // Second gate: OR gate with inputs x and y
    xor gate3(z, out1, out2); // Third gate: XOR gate with inputs from the outputs of gate1 and gate2
    
endmodule
