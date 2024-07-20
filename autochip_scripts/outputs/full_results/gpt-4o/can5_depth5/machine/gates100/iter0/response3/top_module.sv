module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

// Perform AND operation on all bits of the input vector
assign out_and = &in;

// Perform OR operation on all bits of the input vector
assign out_or = |in;

// Perform XOR operation on all bits of the input vector
assign out_xor = ^in;

endmodule
