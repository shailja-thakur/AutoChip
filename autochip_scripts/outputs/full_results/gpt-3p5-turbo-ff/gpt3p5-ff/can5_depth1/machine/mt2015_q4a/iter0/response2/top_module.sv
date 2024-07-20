module top_module(
    input x,
    input y,
    output z);
    
    // XOR gate
    wire xor_output;
    xor xor_gate(
        .a(x),
        .b(y),
        .z(xor_output)
    );
    
    // AND gate
    wire and_output;
    and and_gate(
        .a(xor_output),
        .b(x),
        .z(and_output)
    );
    
    // assign output
    assign z = and_output;
    
endmodule
