module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg state, next_state;

	// State Encoding
	localparam STATE_A = 1'b0;
	localparam STATE_B = 1'b1;

	// State Transition Logic
	always @(*) begin
		case(state)
			STATE_A: next_state = (in) ? STATE_A : STATE_B;
			STATE_B: next_state = (in) ? STATE_B : STATE_A;
			default: next_state = STATE_B;
		endcase
	end

	// State Register Update
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_B;
		else
			state <= next_state;
	end

	// Output Logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			out <= 1;
		else
			out <= (state == STATE_B);
	end

endmodule
