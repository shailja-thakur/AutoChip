module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

wire [98:0] temp_both;
wire [99:1] temp_any;
wire [99:0] temp_diff;

// Compare each bit with its left neighbor
assign temp_both[0] = in[0] & in[99];
assign temp_both[98:1] = in[98:1] & in[97:0];

// Compare each bit with its right neighbor
assign temp_any[99] = in[99] | in[0];
assign temp_any[98:1] = in[98:1] | in[99:2];
assign temp_any[0] = in[0] | in[1];

// Compare each bit with its left neighbor
assign temp_diff[0] = in[0] != in[99];
assign temp_diff[98:1] = in[98:1] != in[97:0];
assign temp_diff[99] = in[99] != in[0];

// Remove MSB from out_any since it has no right neighbor
assign out_any = temp_any[99:1];

// Assign outputs
assign out_both = temp_both;
assign out_any = temp_any;
assign out_different = temp_diff;

endmodule
