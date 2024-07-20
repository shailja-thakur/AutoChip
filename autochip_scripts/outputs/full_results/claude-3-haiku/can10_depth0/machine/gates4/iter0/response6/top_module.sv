module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [3:0] in_wire;
assign in_wire = in;

// Perform the logical AND operation on all bits of in[3:0]
assign out_and = &in_wire;

// Perform the logical OR operation on all bits of in[3:0]
assign out_or = |in_wire;

// Perform the logical XOR operation on all bits of in[3:0]
assign out_xor = ^in_wire;

endmodule
