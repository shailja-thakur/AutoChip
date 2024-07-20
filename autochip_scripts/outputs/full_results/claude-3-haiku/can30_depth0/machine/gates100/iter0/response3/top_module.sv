module top_module (
    input wire [99:0] in,
    output wire out_and,
    output wire out_or,
    output wire out_xor
);

// AND operation
assign out_and = &in;

// OR operation
assign out_or = |in;

// XOR operation
assign out_xor = ^in;

endmodule
