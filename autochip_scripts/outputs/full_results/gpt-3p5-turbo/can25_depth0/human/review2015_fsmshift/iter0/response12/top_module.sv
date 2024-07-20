module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;

	always @(posedge clk or posedge reset) begin
		if (reset)
			counter <= 4'b0;
		else if (counter == 4'b1111)
			counter <= 4'b0;
		else
			counter <= counter + 1'b1;
	end

	assign shift_ena = (counter == 4'b1111);

endmodule
