module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State declaration
	typedef enum reg [1:0] {
		S0, // Original state (before inversion)
		S1, // After inversion, before adding 1
		S2  // After adding 1
	} state_t;
	
	state_t state, next_state;
	reg carry;

	// Next state logic (Moore FSM)
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
			carry <= 1'b1; // Initialize carry to 1 for 2's complement addition
		end else begin
			state <= next_state;
		end
	end

	// Output logic and state transitions
	always @(*) begin
		case (state)
			S0: begin
				z = x;
				next_state = (x == 1'b1) ? S1 : S0; // Invert only when x is 1
			end
			S1: begin
				z = ~x;
				next_state = S2;
			end
			S2: begin
				z = ~x + carry;
				carry = 1'b0; // Adding 1 only once
				next_state = S2;
			end
			default: begin
				z = x;
				next_state = S0;
			end
		endcase
	end
endmodule
