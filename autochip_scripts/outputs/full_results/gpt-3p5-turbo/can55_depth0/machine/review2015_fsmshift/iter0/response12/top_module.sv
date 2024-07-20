module top_module(
	input clk,
	input reset,
	output reg [2:0] state,
	output reg shift_ena);

	always @(posedge clk) begin
		if(reset == 1'b1)
			state <= 3'b0;
		else begin
			case(state)
				3'b0: state <= 3'b1;
				3'b1: state <= 3'b10;
				3'b10: state <= 3'b11;
				3'b11: state <= 3'b100;
				default: state <= 3'b100;
			endcase
		end
	end

	assign shift_ena = (state == 3'b0 || state == 3'b1 || state == 3'b10 || state == 3'b11);

endmodule
