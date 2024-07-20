module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);
	
	reg [31:0] capture_reg;
	reg [31:0] prev_in;

	always @(posedge clk or posedge reset) begin
		if (reset)
			capture_reg <= 0;
		else begin
			prev_in <= in;
			capture_reg <= ~in & prev_in;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else
			out <= capture_reg;
	end
	
endmodule
