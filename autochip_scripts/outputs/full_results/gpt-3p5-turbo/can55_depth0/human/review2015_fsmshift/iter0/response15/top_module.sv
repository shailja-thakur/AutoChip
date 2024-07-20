module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;
	reg enable;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			counter <= 4'b0;
		else if (counter == 4'b1110)
			counter <= 4'b0;
		else if (counter == 4'b0)
			counter <= 4'b1;
		else
			counter <= counter + 1'b1;
	end

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			enable <= 1'b1;
		else if (counter == 4'b1110)
			enable <= 1'b0;
		else
			enable <= enable;
	end

	assign shift_ena = enable;

endmodule
