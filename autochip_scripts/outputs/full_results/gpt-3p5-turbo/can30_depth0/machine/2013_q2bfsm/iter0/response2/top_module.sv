module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	// Define states
	typedef enum logic [3:0] {
		A, B, S0, S1, S10, G1, G2, P0, P1
	} state_t;
	
	// Declare current state and next state
	state_t current_state, next_state;
	
	// Declare state variables
	logic f_state = 0;
	logic g_state = 0;
	
	// Assign initial state
	always_ff @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// Assign next state and output values based on current state and inputs
	always_comb begin
		case (current_state)
			A: begin
				next_state = B;
				f_state = 1'b0;
				g_state = 1'b0;
			end
			B: begin
				next_state = S0;
				f_state = 1'b1;
				g_state = 1'b0;
			end
			S0: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
				f_state = 1'b0;
				g_state = 1'b0;
			end
			S1: begin
				if (x)
					next_state = S1;
				else
					next_state = S10;
				f_state = 1'b0;
				g_state = 1'b0;
			end
			S10: begin
				if (x)
					next_state = G1;
				else
					next_state = S0;
				f_state = 1'b0;
				g_state = 1'b0;
			end
			G1: begin
				if (y)
					next_state = P1;
				else
					next_state = G2;
				f_state = 1'b0;
				g_state = 1'b1;
			end
			G2: begin
				if (y)
					next_state = P1;
				else
					next_state = P0;
				f_state = 1'b0;
				g_state = 1'b1;
			end
			P0: begin
				next_state = P0;
				f_state = 1'b0;
				g_state = 1'b0;
			end
			P1: begin
				next_state = P1;
				f_state = 1'b0;
				g_state = 1'b1;
			end
		endcase
	end
	
	// Assign output values
	assign f = f_state;
	assign g = g_state;

endmodule
