module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Declare the states as parameters
parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
// Declare the state and next_state variables
reg [2:0] state, next_state;

// Combinational logic to determine the next state based on current state and input w
always @ (state, w) begin
	case (state)
		A: if (w) next_state = A; else next_state = B;
		B: if (w) next_state = D; else next_state = C;
		C: if (w) next_state = D; else next_state = E;
		D: if (w) next_state = A; else next_state = F;
		E: if (w) next_state = D; else next_state = E;
		F: if (w) next_state = D; else next_state = C;
	endcase
end

// Sequential logic to update the state and output z on positive edge of clk
always @ (posedge clk) begin
	if (reset) state <= A; // Reset to state A if reset signal is high
	else state <= next_state; // Transition to next state
end

// Assign the output z based on the current state
assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
