module top_module(
    input x,
    input y,
    output z);
    
    wire out1, out2;

    and gate1 (out1, x, y);   // First gate: AND gate with inputs x and y, output out1
    or  gate2 (out2, y, x);   // Second gate: OR gate with inputs y and x, output out2
    xor gate3 (z, out1, out2);// Third gate: XOR gate with inputs out1 and out2, output z

endmodule
