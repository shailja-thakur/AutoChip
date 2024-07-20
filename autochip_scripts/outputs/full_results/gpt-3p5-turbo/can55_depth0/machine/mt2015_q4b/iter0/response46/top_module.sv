module top_module(
    input x,
    input y,
    output z);

    // Declare internal wires
    wire x_xor_y;
    
    // Assign internal wires
    assign x_xor_y = x ^ y;
    assign z = !x_xor_y;
    
endmodule
