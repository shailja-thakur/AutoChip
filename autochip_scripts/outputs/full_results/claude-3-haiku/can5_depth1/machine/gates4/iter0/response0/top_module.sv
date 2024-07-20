module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [3:0] in_wire;
assign in_wire = in;

// Assign the outputs based on the specified operations
assign out_and = &in_wire;
assign out_or = |in_wire;
assign out_xor = ^in_wire;

endmodule
