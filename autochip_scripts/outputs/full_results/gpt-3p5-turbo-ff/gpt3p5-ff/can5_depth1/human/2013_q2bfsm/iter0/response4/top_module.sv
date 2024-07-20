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
		STATE_A,
		STATE_B,
		STATE_C,
		STATE_D
	} state_t;
	
	// Define internal signals
	reg state_t current_state, next_state;
	reg f_reg, g_reg;
	reg [2:0] x_buffer;
	reg [1:0] y_counter;
	
	// Assign initial state
	always_ff @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			current_state <= STATE_A;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Assign next state and outputs based on current state and inputs
	always_comb begin
		next_state = current_state;
		
		case (current_state)
			STATE_A: begin
				f_reg = 0;
				g_reg = 0;
				if (resetn) begin
					if (x == 1'b1 && x_buffer == 3'b101) begin
						next_state = STATE_B;
						f_reg = 1'b1;
					end
				end
			end
			
			STATE_B: begin
				f_reg = 1'b0;
				if (resetn) begin
					if (x == 1'b1 && x_buffer == 3'b101) begin
						next_state = STATE_C;
						g_reg = 1'b1;
					end
				end
			end
			
			STATE_C: begin
				if (resetn) begin
					if (y == 1'b1) begin
						next_state = STATE_D;
						y_counter = 0;
					end else if (y_counter == 2) begin
						next_state = STATE_A;
						g_reg = 1'b0;
					end
				end
			end
			
			STATE_D: begin
				if (resetn) begin
					if (y == 1'b1) begin
						y_counter <= 0;
					end else begin
						y_counter <= y_counter + 1;
						if (y_counter == 2) begin
							next_state = STATE_A;
							g_reg = 1'b0;
						end
					end
				end
			end
		endcase
	end
	
	// Assign outputs
	assign f = f_reg;
	assign g = g_reg;
	
endmodule
