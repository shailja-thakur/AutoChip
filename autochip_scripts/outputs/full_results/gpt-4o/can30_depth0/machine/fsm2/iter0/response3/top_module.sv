module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State declaration
	typedef enum reg [1:0] {A = 2'b00, B = 2'b01} state_t;
	state_t state, next_state;

	// Combinational always block to determine next state
	always @(*) begin
		case (state)
			A: if (j) next_state = B;
			   else next_state = A;
			B: if (k) next_state = A;
			   else next_state = B;
			default: next_state = A; // Default state to handle unexpected cases
		endcase
	end

	// Clocked always block to update state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A; // Reset state to A
		else
			state <= next_state; // Update state to next state
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			out <= 0; // Output low for state A
		else 
			out <= (state == B); // Output high for state B
	end

endmodule
