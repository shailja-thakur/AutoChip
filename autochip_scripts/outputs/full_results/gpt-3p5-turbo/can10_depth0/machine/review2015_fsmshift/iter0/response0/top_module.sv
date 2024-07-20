module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	assign shift_ena = (state == 3'b0 || state == 3'b1 || state == 3'b2 || state == 3'b3);

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 3'b0;
		else if (state == 3'b3)
			state <= 3'bDone;
		else
			state <= state + 1;
	end

endmodule
