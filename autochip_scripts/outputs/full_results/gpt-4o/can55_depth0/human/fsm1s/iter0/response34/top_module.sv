module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	reg state, next_state;
	localparam A = 1'b0, B = 1'b1;

	// State transition on clock edge with reset
	always @(posedge clk) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			B: if (in == 1) next_state = B; else next_state = A;
			A: if (in == 1) next_state = A; else next_state = B;
			default: next_state = B;
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			B: out = 1;
			A: out = 0;
			default: out = 1;
		endcase
		end

endmodule
