module top_module (
	input [99:0] in,
	output reg [98:0] out_both,
	output reg [99:1] out_any,
	output reg [99:0] out_different
);

	always @(in) begin
		out_both = in[98:0] & in[99:1];
		out_any = in[99:0];
		out_different = {in[0]} ^ in;
	end

endmodule
