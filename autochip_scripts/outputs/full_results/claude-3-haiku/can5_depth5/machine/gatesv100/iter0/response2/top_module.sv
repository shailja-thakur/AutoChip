module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

// Shift the input signal by one bit
wire [99:0] shifted_in;
assign shifted_in = {in[98:0], in[99]};

// Generate the out_both signal
assign out_both = in & shifted_in[99:1];

// Generate the out_any signal
assign out_any = in | shifted_in;

// Generate the out_different signal
assign out_different[99:1] = in ^ shifted_in[99:1];
assign out_different[0] = in[0] ^ shifted_in[99];

endmodule
