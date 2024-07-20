module top_module (
	input [3:0] in,
	output reg [2:0] out_both,
	output reg [3:1] out_any,
	output reg [3:0] out_different
);

	// out_both calculation: each bit of out_both should be 1 if in[n] and in[n+1] are both 1
	always @(*) begin
		out_both[2] = in[3] & in[2];
		out_both[1] = in[2] & in[1];
		out_both[0] = in[1] & in[0];
	end

	// out_any calculation: each bit of out_any should be 1 if in[n] or in[n-1] are 1
	always @(*) begin
		out_any[3] = in[3] | in[2];
		out_any[2] = in[2] | in[1];
		out_any[1] = in[1] | in[0];
	end

	// out_different calculation: each bit of out_different should be 1 if in[n] is different from in[n+1]
	always @(*) begin
		out_different[3] = in[3] ^ in[0];
		out_different[2] = in[2] ^ in[3];
		out_different[1] = in[1] ^ in[2];
		out_different[0] = in[0] ^ in[1];
	end
endmodule
