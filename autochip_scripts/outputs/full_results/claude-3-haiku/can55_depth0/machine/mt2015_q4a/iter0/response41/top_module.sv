module top_module(
    input x,
    input y,
    output z
);

    wire xor_out;
    
    // Perform the XOR operation on the two inputs
    assign xor_out = x ^ y;
    
    // Assign the output z based on the XOR result and the first input x
    assign z = xor_out & x;

endmodule
