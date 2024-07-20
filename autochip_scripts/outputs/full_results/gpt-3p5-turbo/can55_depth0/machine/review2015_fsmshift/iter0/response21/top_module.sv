module top_module(
	input clk,
	input reset,
	output shift_ena,
	output [2:0] state);

	reg [2:0] state_next;
	always @(posedge clk) begin
		if (reset) begin
			state_next <= 3'b000;
		end else if (state == 3'b000) begin
			state_next <= 3'b001;
		end else if (state == 3'b001) begin
			state_next <= 3'b010;
		end else if (state == 3'b010) begin
			state_next <= 3'b011;
		end else if (state == 3'b011) begin
			state_next <= 3'b100;
		end else begin
			state_next <= 3'b100;
		end
	end

	assign state = state_next;

	assign shift_ena = (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011);

endmodule
