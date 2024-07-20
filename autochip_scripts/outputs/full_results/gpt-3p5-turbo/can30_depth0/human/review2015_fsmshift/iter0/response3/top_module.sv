module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] count;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			count <= 4'b0000;
		else if (count == 4'b1101)
			count <= 4'b0000;
		else
			count <= count + 1;
	end

	assign shift_ena = (count == 4'b1101);

endmodule
