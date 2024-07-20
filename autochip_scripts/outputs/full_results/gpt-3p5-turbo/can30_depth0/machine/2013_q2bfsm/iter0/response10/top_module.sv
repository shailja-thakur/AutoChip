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
		A,
		B,
		S0,
		S1,
		S10,
		G1,
		G2,
		P0,
		P1
	} state_type;
	
	// Define state signals
	logic [3:0] current_state;
	logic [3:0] next_state;
	
	// Assign initial state
	always_ff @(posedge clk or negedge resetn) begin
		if (~resetn)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// Define outputs based on current state
	assign f = (current_state == B);
	assign g = (current_state == G1 || current_state == G2 || current_state == P1);
	
	// Define next state logic
	always_comb begin
		case (current_state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = S0;
			end
			
			B: begin
				next_state = S0;
			end
			
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

endmodule
