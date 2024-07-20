module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// States definition
	typedef enum logic {
		A = 1'b0,
		B = 1'b1
	} state_t;

	// Current and next state variables
	state_t state, next_state;

	// Combinational logic block to determine the next state
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = A; // default state 
		endcase
	end

	// Sequential logic block to update the state register on clock edge
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic
	always @(state) begin
		out = (state == B);
	end

endmodule
