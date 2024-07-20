module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// Define the state enumeration
typedef enum logic [1:0] {
	A,
	B
} state_type;

// Define the state and next_state variables
state_type state, next_state;

// Define the output variable
logic out_reg;

// Define the always_ff block for clocked and synchronous logic
always_ff @(posedge clk, posedge areset)
begin
	// Reset the state to B on the rising edge of areset
	if (areset)
		state <= B;
	else
		state <= next_state; // Update the state with the next_state

	// Determine the next_state based on the current state and input in
	case (state)
		A: next_state = (in) ? A : B; // If in is high, next_state is A, otherwise B
		B: next_state = (in) ? B : A; // If in is high, next_state is B, otherwise A
	endcase
end

// Define the always_comb block for combinational logic
always_comb
begin
	// Set the output based on the current state
	out_reg = (state == B) ? 1'b1 : 1'b0;
end

// Assign the output to the registered output
assign out = out_reg;

endmodule
