module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	reg [99:0] in_shifted;
	reg [99:1] in_shifted_rev;
	
	always @* begin
		out_both = in[99:1] & in_shifted[98:0];
		out_any = in[99:2] | in_shifted_rev[99:2];
		out_different = in[99:0] !== in_shifted[99:0];
	end
	
	// Shift in to the left
	always @(posedge clk)
		in_shifted <= {in[98:0], in[99]};
		
	// Shift in to the right
	always @(posedge clk)
		in_shifted_rev <= {in[99:1], in[0]};
		
endmodule
