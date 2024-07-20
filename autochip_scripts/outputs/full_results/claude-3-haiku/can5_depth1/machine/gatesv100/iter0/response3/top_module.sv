module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

wire [99:0] shifted_in;

// Shift the input vector by one bit to the right
assign shifted_in[99:1] = in[98:0];
assign shifted_in[0] = in[99];

// Compute the output signals
assign out_both = in & shifted_in[98:0];
assign out_any = in | shifted_in;
assign out_different = in ^ shifted_in;

endmodule
