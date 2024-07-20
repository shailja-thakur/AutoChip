module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Changed first gate to an OR gate
    or gate1(out1, x, y);
    
    // Changed second gate to an AND gate
    and gate2(out2, x, y);
    
    // Changed third gate to an XOR gate
    xor gate3(z, out1, out2);

endmodule
