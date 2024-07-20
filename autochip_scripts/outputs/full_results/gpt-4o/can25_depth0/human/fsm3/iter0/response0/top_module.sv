module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define state encodings
	typedef enum reg [1:0] {
		STATE_A = 2'b00,
		STATE_B = 2'b01,
		STATE_C = 2'b10,
		STATE_D = 2'b11
	} state_t;

	// State variables
	state_t state, next_state;

	// Combinational logic for the state transitions
	always @(*) begin
		case (state)
			STATE_A: next_state = in ? STATE_B : STATE_A;
			STATE_B: next_state = in ? STATE_B : STATE_C;
			STATE_C: next_state = in ? STATE_D : STATE_A;
			STATE_D: next_state = in ? STATE_B : STATE_C;
			default: next_state = STATE_A; // Default case to avoid latches
		endcase
	end

	// Synchronous state update with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_A;
		else
			state <= next_state;
	end

	// Output logic based on current state
	always @(*) begin
		case (state)
			STATE_A: out = 1'b0;
			STATE_B: out = 1'b0;
			STATE_C: out = 1'b0;
			STATE_D: out = 1'b1;
			default: out = 1'b0; // Default case to avoid latches
		endcase
	end

endmodule
