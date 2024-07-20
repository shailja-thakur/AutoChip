module top_module(
    input x,
    input y,
    output z);

    wire x_and_y;
    wire x_xor_y;
    
    assign x_and_y = x & y;
    assign x_xor_y = x ^ y;
    
    assign z = x_and_y & x;

endmodule
