module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	// Define the states of the FSM
	typedef enum logic [1:0] {
		STATE_A,
		STATE_B,
		STATE_C,
		STATE_D
	} state_type;
	
	// Define the signals for the current state and the next state
	logic [1:0] current_state;
	logic [1:0] next_state;
	
	// Define additional signals for monitoring x and y inputs
	logic x_prev1; // Stores the previous value of x
	logic x_prev2; // Stores the value of x two clock cycles ago
	
	// Define flip flops for f and g outputs
	reg f_reg;
	reg g_reg;
	
	always @(posedge clk) begin
		if (!resetn) begin
			// Synchronous reset
			current_state <= STATE_A;
			f_reg <= 0;
			g_reg <= 0;
			x_prev1 <= 0;
			x_prev2 <= 0;
		end else begin
			current_state <= next_state;
			x_prev2 <= x_prev1;
			x_prev1 <= x;
			
			// Next state logic
			case (current_state)
				STATE_A: begin
					if (x_prev2 && !x_prev1 && x) begin
						next_state <= STATE_B;
						f_reg <= 1;
					end else begin
						next_state <= STATE_A;
						f_reg <= 0;
					end
					
					g_reg <= 0;
				end
				
				STATE_B: begin
					next_state <= STATE_C;
					g_reg <= 0;
				end
				
				STATE_C: begin
					if (x_prev2 && !x_prev1 && x) begin
						next_state <= STATE_D;
						g_reg <= 1;
					end else begin
						next_state <= STATE_A;
						g_reg <= 0;
					end
				end
				
				STATE_D: begin
					if (y) begin
						next_state <= STATE_D;
						g_reg <= 1;
					end else begin
						next_state <= STATE_A;
						g_reg <= 0;
					end
				end
			endcase
		end
	end
	
	// Assign the outputs
	assign f = f_reg;
	assign g = g_reg;
	
endmodule
