module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	// Define states
	typedef enum logic [1:0] {
		A, B, C, D, E, F
	} state_type;
	
	// Define state signals
	state_type current_state, next_state;
	
	// Define output signals
	logic f_next, g_next;
	
	// Register flip-flops for state and output signals
	always_ff @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			current_state <= A;
			f <= 0;
			g <= 0;
		end else begin
			current_state <= next_state;
			f <= f_next;
			g <= g_next;
		end
	end
	
	// Combinational logic for next state and output signals
	always_comb begin
		next_state = current_state;
		f_next = f;
		g_next = g;
		
		case (current_state)
			A: begin
				if (!resetn)
					next_state = A;
				else if (x == 1'b1 && y == 1'b1 && #1 x == 1'b0 && #1 x == 1'b1)
					next_state = B;
			end
			
			B: begin
				if (!resetn)
					next_state = A;
				else if (x == 1'b1 && y == 1'b1)
					next_state = C;
			end
			
			C: begin
				if (!resetn)
					next_state = A;
				else if (y == 1'b1)
					next_state = D;
				else
					next_state = E;
			end
			
			D: begin
				if (!resetn)
					next_state = A;
				else if (y == 1'b1)
					next_state = D;
				else
					next_state = F;
			end
			
			E: begin
				if (!resetn)
					next_state = A;
				else if (x == 1'b1 && y == 1'b1)
					next_state = C;
			end
			
			F: begin
				if (!resetn)
					next_state = A;
				else if (x == 1'b1 && y == 1'b1)
					next_state = C;
			end
		endcase
		
		case (next_state)
			A: begin
				f_next = 1'b0;
				g_next = 1'b0;
			end
			
			B: begin
				f_next = 1'b1;
				g_next = 1'b0;
			end
			
			C: begin
				f_next = 1'b0;
				g_next = 1'b0;
			end
			
			D: begin
				f_next = 1'b0;
				g_next = 1'b1;
			end
			
			E: begin
				f_next = 1'b0;
				g_next = 1'b1;
			end
			
			F: begin
				f_next = 1'b0;
				g_next = 1'b0;
			end
		endcase
	end
	
endmodule
