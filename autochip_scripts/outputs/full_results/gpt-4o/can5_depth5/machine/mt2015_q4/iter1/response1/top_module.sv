module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate (AND gate)
    assign out1 = x & y;
        
    // Second gate (AND gate, corrected from OR gate)
    assign out2 = x & y;

    // Third gate (OR gate, corrected from XOR gate)
    assign z = out1 | out2;

endmodule
