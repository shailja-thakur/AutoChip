module top_module(
	input clk,
	input reset,
	output reg shift_ena);
	
	reg [2:0] state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
		end else if (state == 3) begin
			state <= 4;
		end else begin
			state <= state + 1;
		end
	end

	assign shift_ena = (state == 0) || (state == 1) || (state == 2) || (state == 3);

endmodule
