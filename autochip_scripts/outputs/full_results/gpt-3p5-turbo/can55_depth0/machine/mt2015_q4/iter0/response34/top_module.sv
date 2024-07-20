module top_module(
    input x,
    input y,
    output z);
    
    wire a_in_gate1, b_in_gate1;
    wire a_out_gate1, b_out_gate1;
    wire a_in_gate2, b_in_gate2;
    wire a_out_gate2, b_out_gate2;
    
    // First gate
    and gate1 (.a(x), .b(y), .z1(a_in_gate1));
    or gate2 (.a(x), .b(y), .z1(b_in_gate1));
    
    // Second gate
    and gate3 (.a(y), .b(x), .z1(a_in_gate2));
    or gate4 (.a(y), .b(x), .z1(b_in_gate2));
    
    // Third gate
    and gate5 (.a(a_out_gate1), .b(b_out_gate2), .z1(z));
    
    // Connections to the gates
    assign a_out_gate1 = a_in_gate1;
    assign b_out_gate1 = b_in_gate1;
    assign a_out_gate2 = a_in_gate2;
    assign b_out_gate2 = b_in_gate2;
    
endmodule
