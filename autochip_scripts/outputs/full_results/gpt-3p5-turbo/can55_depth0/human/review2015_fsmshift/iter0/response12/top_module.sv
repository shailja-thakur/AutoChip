module top_module(
	input clk,
	input reset,
	output reg shift_ena);
	
	reg [3:0] counter;
	reg [3:0] pattern;

	always @(posedge clk or posedge reset) begin
		if(reset)
			counter <= 0;
		else if(counter < 4'b1101)
			counter <= counter + 1;
		else
			counter <= 0;
	end

	always @(posedge clk or posedge reset) begin
		if(reset)
			pattern <= 4'b0000;
		else if(counter < 4'b1101)
			pattern <= 4'b1101;
		else
			pattern <= 4'b0000;
	end

	assign shift_ena = (pattern == 4'b1101) ? 1'b1 : 1'b0;
endmodule
