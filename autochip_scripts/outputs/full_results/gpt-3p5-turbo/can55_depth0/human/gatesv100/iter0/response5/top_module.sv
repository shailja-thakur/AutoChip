module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

// Internal wires
wire [98:0] in_left;
wire [99:1] in_right;

// Generate in_left by shifting in right by 1 bit
assign in_left = in[98:0];

// Generate in_right by shifting in left by 1 bit
assign in_right = {in[99], in[98:0]};

// out_both
assign out_both = in[98:0] & in_left;

// out_any
assign out_any = in[99:1] | in_right;

// out_different
assign out_different = in[98:0] ^ in_left;

endmodule
