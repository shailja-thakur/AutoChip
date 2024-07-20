module top_module(
    input x,
    input y,
    output z);
    
    // Declare internal wires
    wire temp;
    
    // Compute x XOR y
    xor(xor_result, x, y);
    
    // Compute (x XOR y) AND x
    and(z, xor_result, x);
    
endmodule
