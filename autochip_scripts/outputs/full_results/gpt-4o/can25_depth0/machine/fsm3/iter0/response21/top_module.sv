module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the states
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		// Default next state
		next_state = state;
		case (state)
			A: if (in) next_state = B;
				else next_state = A;
			B: if (in) next_state = B;
				else next_state = C;
			C: if (in) next_state = D;
				else next_state = A;
			D: if (in) next_state = B;
				else next_state = C;
		endcase
	end

	// State register logic with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	assign out = (state == D);

endmodule
