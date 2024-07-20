module top_module(
    input x,
    input y,
    output z);
    
    // internal wires
    wire x_xor_y;
    
    // create gates
    assign x_xor_y = x ^ y;
    assign z = x_xor_y & x;
    
endmodule
