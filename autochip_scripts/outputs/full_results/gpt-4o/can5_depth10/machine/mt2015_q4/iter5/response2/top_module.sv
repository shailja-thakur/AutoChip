module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate: AND gate with inputs x and y
    and gate1(out1, x, y);
    
    // Second gate: OR gate with inputs y and x
    or gate2(out2, y, x);
    
    // Third gate: AND gate with inputs out1 and out2
    and gate3(z, out1, out2);

endmodule
