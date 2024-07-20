module top_module(
    input x,
    input y,
    output z
);

    // First gate
    wire gate1_out;
    wire gate1_a;
    wire gate1_b;
    
    assign gate1_a = x;
    assign gate1_b = y;
    and gate1(gate1_out, gate1_a, gate1_b);
    
    // Second gate
    wire gate2_out;
    wire gate2_a;
    wire gate2_b;
    
    assign gate2_a = y;
    assign gate2_b = x;
    and gate2(gate2_out, gate2_a, gate2_b);
    
    // Third gate
    wire gate3_out;
    wire gate3_a;
    wire gate3_b;
    
    assign gate3_a = gate1_out;
    assign gate3_b = gate2_out;
    and gate3(gate3_out, gate3_a, gate3_b);
    
    assign z = gate3_out;
    
endmodule
