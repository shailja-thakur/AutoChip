module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    
    assign out_and = &in;  // Perform a bit-wise AND reduction on all elements of the input vector
    assign out_or = |in;   // Perform a bit-wise OR reduction on all elements of the input vector
    assign out_xor = ^in;  // Perform a bit-wise XOR reduction on all elements of the input vector
    
endmodule
