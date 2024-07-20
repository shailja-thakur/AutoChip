module top_module(
    input x,
    input y,
    output z);

    // intermediate wire to store the result of (x ^ y)
    wire x_xor_y;
    
    // assign the value of (x ^ y) to x_xor_y
    assign x_xor_y = x ^ y;
    
    // assign the value of (x_xor_y & x) to z
    assign z = x_xor_y & x;
    
endmodule
