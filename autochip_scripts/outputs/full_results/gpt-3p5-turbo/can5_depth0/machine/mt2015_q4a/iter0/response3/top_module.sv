module top_module(
    input x,
    input y,
    output z);

    // Declare internal signals
    wire xor_result;
    
    // XOR gate to compute the exclusive OR of x and y
    xor gate_xor(x, y, xor_result);
    
    // AND gate to compute the logical AND of xor_result and x
    and gate_and(xor_result, x, z);
    
endmodule
