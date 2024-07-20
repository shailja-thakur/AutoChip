module top_module(
    input x,
    input y,
    output z);

    // Internal wire to store the result of x ^ y
    wire x_xor_y;
    
    // Implementing the XOR gate
    assignment #1(a, x, y);
    
    // Implementing the AND gate
    assignment #2(z, x_xor_y, x);
    
endmodule
