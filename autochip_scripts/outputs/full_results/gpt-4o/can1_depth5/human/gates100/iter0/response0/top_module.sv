module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    
    // AND operation
    assign out_and = &in;
    
    // OR operation
    assign out_or = |in;
    
    // XOR operation
    assign out_xor = ^in;

endmodule
