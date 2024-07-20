module top_module(
    input x,
    input y,
    output z);

    // Internal wire to store the result of (x^y) operation
    wire x_xor_y;
    
    // Internal wire to store the result of ((x^y) & x) operation
    wire z_internal;
    
    // XOR gate to perform x^y operation
    xor gate_xor (x_xor_y, x, y);
    
    // AND gate to perform (x^y) & x operation
    and gate_and (z_internal, x_xor_y, x);
    
    // Assign the value of z_internal to the output z
    assign z = z_internal;

endmodule
