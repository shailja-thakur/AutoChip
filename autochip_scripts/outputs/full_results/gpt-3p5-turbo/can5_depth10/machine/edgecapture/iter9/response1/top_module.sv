module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] in_old;
	reg [31:0] out_temp;
	initial begin
		in_old = 0;
		out_temp = 0;
	end

	always @(posedge clk) begin
		if (reset) begin
			out <= 0;
		end else begin
			out_temp <= out | (~in & in_old);
			in_old <= in;
			out <= out_temp;
		end
	end

endmodule
