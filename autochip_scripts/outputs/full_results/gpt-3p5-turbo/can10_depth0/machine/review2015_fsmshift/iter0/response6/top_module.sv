module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b0;
		end else begin
			case (state)
				3'b0: state <= 3'b1;
				3'b1: state <= 3'b10;
				3'b10: state <= 3'b11;
				3'b11: state <= 3'b100;
				default: state <= 3'b1000;
			endcase
		end
	end

	assign shift_ena = (state != 3'b1000);

endmodule
