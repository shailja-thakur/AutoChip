module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define states
	typedef enum logic [1:0] {A, B, C, D} state_t;
	
	// Define signals
	logic [1:0] current_state, next_state;
	logic out_reg;
	
	// Assign initial state
	always @ (posedge clk or posedge areset)
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	
	// Assign next state and output
	always_comb begin
		case (current_state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out_reg = 0;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out_reg = 0;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
				out_reg = 0;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out_reg = 1;
			end
			default: begin
				next_state = A;
				out_reg = 0;
			end
		endcase
	end
	
	// Assign output
	assign out = out_reg;
endmodule
