module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [3:0] in_wire;
assign in_wire = in;

// Perform logical AND operation
assign out_and = &in_wire;

// Perform logical OR operation
assign out_or = |in_wire;

// Perform logical XOR operation
assign out_xor = ^in_wire;

endmodule
