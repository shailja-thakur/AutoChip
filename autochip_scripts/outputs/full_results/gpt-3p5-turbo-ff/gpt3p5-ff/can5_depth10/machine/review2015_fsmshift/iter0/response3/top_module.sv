module top_module(
	input clk,
	input reset,
	output shift_ena,
	output reg [2:0] state);

	always @(posedge clk) begin
		if (reset)
			state <= 3'b000; // set state to B0 when reset is 1
		else begin
			case (state)
				3'b000: state <= 3'b001; // transition from B0 to B1
				3'b001: state <= 3'b010; // transition from B1 to B2
				3'b010: state <= 3'b011; // transition from B2 to B3
				3'b011: state <= 3'b100; // transition from B3 to Done
				default: state <= 3'b100; // set state to Done if not B0, B1, B2, or B3
			endcase
		end
	end

	assign shift_ena = (state == 3'b000) || (state == 3'b001) || (state == 3'b010) || (state == 3'b011);

endmodule
