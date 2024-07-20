module top_module(
    input x,
    input y,
    output z);
   
    wire out1, out2;

    // First gate (AND gate)
    and and_gate1 (.a(x), .b(y), .out(out1));
    
    // Second gate (OR gate)
    or or_gate2 (.a(y), .b(x), .out(out2));
    
    // Third gate (XOR gate)
    xor xor_gate3 (.a(out1), .b(out2), .out(z));

endmodule
