module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	typedef enum logic [0:0] {
		A = 1'b0,
		B = 1'b1
	} state_t;

	// State variables
	state_t state, next_state;

	// Combinational always block for determining next state
	always @(*) begin
		case (state)
			A: begin
				if (j)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (k)
					next_state = A;
				else
					next_state = B;
			end
			default: next_state = A; // Default state
		endcase
	end

	// Clocked always block for state transitions and resets
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		out = (state == B);
		end

endmodule
