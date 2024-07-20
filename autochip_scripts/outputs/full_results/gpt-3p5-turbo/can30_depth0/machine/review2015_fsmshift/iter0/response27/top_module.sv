module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 0;
		else if (state == 3'b11)
			state <= 3'b100;
		else
			state <= state + 1;
	end

	assign shift_ena = (state == 3'b00 || state == 3'b01 || state == 3'b10 || state == 3'b11);

endmodule
