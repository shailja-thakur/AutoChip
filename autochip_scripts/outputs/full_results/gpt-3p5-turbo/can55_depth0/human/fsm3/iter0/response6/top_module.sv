module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define states
	typedef enum logic [7:0] {
		A,
		B,
		C,
		D
	} state_type;

	// Define state signals
	logic [1:0] state;
	logic [1:0] next_state;

	// Define output signal
	logic output;

	// Implement the state machine
	always_ff @(posedge clk, posedge areset)
	begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	always_comb
	begin
		// Define default next state
		next_state = state;

		case (state)
			A: 
				begin
					if (in)
						next_state = B;
					else
						next_state = A;
					
					output = 0;
				end
			B: 
				begin
					if (in)
						next_state = B;
					else
						next_state = C;
					
					output = 0;
				end
			C: 
				begin
					if (in)
						next_state = D;
					else
						next_state = A;
					
					output = 0;
				end
			D: 
				begin
					if (in)
						next_state = B;
					else
						next_state = C;
					
					output = 1;
				end
			default:
				begin
					next_state = A;
					output = 0;
				end
		endcase
	end
	
	// Output signal assignment
	assign out = output;

endmodule
