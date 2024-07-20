module top_module (
	input [2:0] in,
	output reg [1:0] out
);

	always @(in)
	begin
		out = {in[2] + in[1] + in[0], in[2] + in[1]};
	end

endmodule
