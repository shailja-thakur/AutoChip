module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] in_wire;
assign in_wire = in;

// 100-input AND gate
assign out_and = &in_wire;

// 100-input OR gate
assign out_or = |in_wire;

// 100-input XOR gate
assign out_xor = ^in_wire;

endmodule
