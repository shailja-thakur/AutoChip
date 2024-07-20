module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] in_wires;
assign in_wires = in;

// Perform the logical AND operation
assign out_and = &in_wires;

// Perform the logical OR operation
assign out_or = |in_wires;

// Perform the logical XOR operation
assign out_xor = ^in_wires;

endmodule
