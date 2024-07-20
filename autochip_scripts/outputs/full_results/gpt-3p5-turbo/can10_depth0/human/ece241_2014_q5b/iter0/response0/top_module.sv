module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// State enumeration
	typedef enum logic [1:0] {
		A, B
	} state_type;
	
	reg state, next_state;
	
	// State register
	always @(posedge clk or posedge areset)
		if (areset)
			state <= A;
		else
			state <= next_state;
	
	// Next state logic
	always @*
		case (state)
			A: if (x == 1'b0)
					next_state = A;
				else
					next_state = B;
			B: if (x == 1'b0)
					next_state = B;
				else
					next_state = B;
		endcase
	
	// Output logic
	always @(state or x)
		case (state)
			A: z = 1'b0;
			B: z = x;
		endcase
	
endmodule
