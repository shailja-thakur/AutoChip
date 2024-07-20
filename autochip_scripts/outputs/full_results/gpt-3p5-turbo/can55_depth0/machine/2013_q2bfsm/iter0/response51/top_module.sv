module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// Define states
	typedef enum logic [6:0] {
		S0,
		S1,
		S10,
		G1,
		G2,
		P0,
		P1
	} state_t;
	
	// Declare current state and next state variables
	reg [6:0] current_state;
	reg [6:0] next_state;
	
	// Assign initial state
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= S0;
		else
			current_state <= next_state;
	end
	
	// Assign next state based on current state and inputs
	always_comb begin
		case (current_state)
			S0: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
			end
			
			S1: begin
				if (x)
					next_state = S1;
				else
					next_state = S10;
			end
			
			S10: begin
				if (x)
					next_state = G1;
				else
					next_state = S0;
			end
			
			G1: begin
				if (y)
					next_state = P1;
				else
					next_state = G2;
			end
			
			G2: begin
				if (y)
					next_state = P1;
				else
					next_state = P0;
			end
			
			P0: begin
				next_state = P0;
			end
			
			P1: begin
				next_state = P1;
			end
		endcase
	end
	
	// Assign output f
	always_comb begin
		if (current_state == G1 || current_state == G2 || current_state == P1)
			f = 1;
		else
			f = 0;
	end
	
	// Assign output g
	always_comb begin
		if (current_state == G1 || current_state == G2 || current_state == P1)
			g = 1;
		else
			g = 0;
	end
	
endmodule
