module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] d_last;

	always @(posedge clk) begin
		if (reset)
			out <= 32'h0;
		else
			out <= out | (~in & d_last);
		
		d_last <= in;
	end

endmodule
