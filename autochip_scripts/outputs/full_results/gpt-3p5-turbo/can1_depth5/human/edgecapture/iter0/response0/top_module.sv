module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] in_previous;  // register to store previous value of 'in'

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			in_previous <= 0;
		end else begin
			in_previous <= in;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out <= 0;
		end else begin
			out <= in_previous & ~in;
		end
	end

endmodule
