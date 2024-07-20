module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
	reg state, next_state;

	// Define states
	localparam STATE_A = 1'b0;
	localparam STATE_B = 1'b1;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_A: next_state = in ? STATE_A : STATE_B;
			STATE_B: next_state = in ? STATE_B : STATE_A;
			default: next_state = STATE_B; // default to state B
		endcase
	end

	// State update logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_B;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			STATE_A: out = 1'b0;
			STATE_B: out = 1'b1;
			default: out = 1'b0; // default to low
		endcase
	end

endmodule
