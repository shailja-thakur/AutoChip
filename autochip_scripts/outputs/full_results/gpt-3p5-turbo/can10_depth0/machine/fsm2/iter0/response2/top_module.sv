module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

// State enumeration
typedef enum logic [1:0] {A, B} state_type;
 
// State and Next State variables
reg state_var;
reg next_state_var;

// Combinational always block for state transition logic
always_comb begin
	if (state_var == A) begin
		if (j == 1'b1)
			next_state_var = B;
		else
			next_state_var = A;
	end
	else if (state_var == B) begin
		if (k == 1'b1)
			next_state_var = A;
		else
			next_state_var = B;
	end
end

// Clocked always block to update state based on next state and areset
always_ff @(posedge clk or posedge areset) begin
	if (areset)
		state_var <= A;
	else
		state_var <= next_state_var;
end

// Output logic for indicating current state
assign out = (state_var == B) ? 1'b1 : 1'b0;

endmodule
