module top_module (
	input [7:0] in,
	output [7:0] out
);

	always @(*)
	begin
		out[7] = in[0];
		out[6] = in[1];
		out[5] = in[2];
		out[4] = in[3];
		out[3] = in[4];
		out[2] = in[5];
		out[1] = in[6];
		out[0] = in[7];
	end

endmodule
