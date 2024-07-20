module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	assign shift_ena = (state == 3'b0) ? 1'b1 : 1'b0;

	always @(posedge clk) begin
		if (reset == 1'b1)
			state <= 3'b0;
		else begin
			case (state)
				3'b0: state <= 3'b1;
				3'b1: state <= 3'b2;
				3'b2: state <= 3'b3;
				3'b3: state <= 3'bDone;
				default: state <= 3'bDone;
			endcase
		end
	end
endmodule
