module top_module (
	input [2:0] in,
	output reg [1:0] out
);

	always @(*) begin
		out[1] = in[2] ^ (in[1] & in[0]);
		out[0] = in[1] ^ in[0];
	end

endmodule
