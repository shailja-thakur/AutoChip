module top_module(
	input wire clk,
	input wire reset,
	input wire [31:0] in,
	output reg [31:0] out);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out <= 0;
		end else begin
			out <= out | (~in & in_old);
		end
	end

	reg [31:0] in_old;

	always @(posedge clk) begin
		in_old <= in;
	end

endmodule
