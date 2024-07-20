module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

wire [99:0] shifted_in;

// Shift the input signal by one bit to the left (equivalent to shifting by one bit position)
assign shifted_in = {in[98:0], 1'b0};

// Generate out_both signal (99 bits)
assign out_both = in[99:1] & shifted_in[99:1];

// Generate out_any signal (100 bits)
assign out_any = in | shifted_in;

// Generate out_different signal (100 bits)
assign out_different = in ^ {shifted_in[98:0], shifted_in[99]};

endmodule
