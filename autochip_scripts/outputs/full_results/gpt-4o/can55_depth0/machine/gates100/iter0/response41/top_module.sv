module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // AND operation: out_and is 1 if all bits in 'in' are 1
    assign out_and = &in;
    
    // OR operation: out_or is 1 if any bit in 'in' is 1
    assign out_or = |in;
    
    // XOR operation: out_xor is 1 if there is an odd number of 1s in 'in'
    assign out_xor = ^in;

endmodule
