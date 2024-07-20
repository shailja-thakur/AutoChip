module top_module (
	input [99:0] in,
	output reg [99:0] out
);
	always @(in) begin
		for (integer i = 0; i <= 99; i = i + 1) begin
			out[i] = in[99 - i];
		end
	end
endmodule
