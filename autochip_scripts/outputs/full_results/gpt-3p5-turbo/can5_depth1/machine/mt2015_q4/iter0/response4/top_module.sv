module top_module(
    input a,
    input b,
    output z);
    
    wire gate1_output;
    wire gate2_output;
    
    // Logic gates
    and gate1(a, b, gate1_output); // First gate with inputs a and b
    xor gate2(b, a, gate2_output); // Second gate with inputs b and a
    and gate3(gate1_output, gate2_output, z); // Third gate with inputs gate1_output and gate2_output
    
endmodule
