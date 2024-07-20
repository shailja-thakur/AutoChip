module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// Define states using one-hot encoding
	typedef enum logic [1:0] {
		A = 2'b01,
		B = 2'b10
	} state_t;

	// Declare state and next_state variables
	reg state_t state, next_state;

	// Declare output reg
	reg z;

	always_ff @(posedge clk, posedge areset)
	begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end
	
	always_comb
	begin
		case(state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = A;
				
				z = 0;
			end
			B: begin
				if (x)
					next_state = B;
				else
					next_state = B;
				
				z = 1;
			end
		endcase
	end
endmodule
