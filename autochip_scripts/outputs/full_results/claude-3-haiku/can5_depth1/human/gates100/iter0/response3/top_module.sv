module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

// Implement the AND gate
assign out_and = &in;

// Implement the OR gate
assign out_or = |in;

// Implement the XOR gate
assign out_xor = ^in;

endmodule
