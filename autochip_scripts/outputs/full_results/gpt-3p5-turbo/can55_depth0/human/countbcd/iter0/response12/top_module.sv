module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	// Define internal wire signals
	wire [3:0] q_ones;
	wire [3:0] q_tens;
	wire [3:0] q_hundreds;
	wire [3:0] q_thousands;
	
	// Instantiate the BCD counter modules
	BCD_counter digit_ones(clk, reset, ena[0], q_ones);
	BCD_counter digit_tens(clk, reset, ena[1], q_tens);
	BCD_counter digit_hundreds(clk, reset, ena[2], q_hundreds);
	BCD_counter digit_thousands(clk, reset, 1'b1, q_thousands);
	
	// Concatenate the individual digit outputs to form the final counter output
	assign q = {q_thousands, q_hundreds, q_tens, q_ones};
	
endmodule
module BCD_counter(
	input clk,
	input reset,
	input enable,
	output reg [3:0] q);
	
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			q <= 4'b0000;
		else if (enable)
			q <= q + 1;
	end
	
endmodule
