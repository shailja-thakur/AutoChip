module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define state encoding
	reg state, next_state;
	localparam A = 0, B = 1;
	
	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: next_state = (j) ? B : A;
			B: next_state = (k) ? A : B;
			default: next_state = A; // Default state
		endcase
	}
	
	// Clocked always block to update the state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A; // Reset to state A
		else
			state <= next_state;
	}
	
	// Output logic
	assign out = (state == B) ? 1 : 0;

endmodule
