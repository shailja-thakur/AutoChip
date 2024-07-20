module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else if (state == 3'b000)
			state <= 3'b001;
		else if (state == 3'b001)
			state <= 3'b010;
		else if (state == 3'b010)
			state <= 3'b011;
		else if (state == 3'b011)
			state <= 3'b100;
		else
			state <= 3'b100;
	end

	assign shift_ena = (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011);

endmodule
