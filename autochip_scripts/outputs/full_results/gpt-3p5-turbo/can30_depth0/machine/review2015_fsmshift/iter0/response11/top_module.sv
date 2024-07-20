module top_module(
	input clk,
	input reset,
	output reg [2:0] state,
	output reg shift_ena);

	// Internal signals
	reg [2:0] next_state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000; // B0
		end else begin
			state <= next_state;
		end
	end

	always @(state) begin
		case (state)
			3'b000: next_state = 3'b001; // B0 -> B1
			3'b001: next_state = 3'b010; // B1 -> B2
			3'b010: next_state = 3'b011; // B2 -> B3
			3'b011: next_state = 3'b100; // B3 -> Done
			default: next_state = 3'b100; // Done
		endcase
	end

	always @(state) begin
		case (state)
			3'b000, 3'b001, 3'b010, 3'b011: shift_ena = 1;
			default: shift_ena = 0;
		endcase
	end

endmodule
