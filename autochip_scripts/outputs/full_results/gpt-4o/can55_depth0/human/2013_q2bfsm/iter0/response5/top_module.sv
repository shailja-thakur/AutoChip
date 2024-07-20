module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State definition
	typedef enum logic [2:0] {
		STATE_A,
		STATE_B,
		STATE_C,
		STATE_D,
		STATE_E,
		STATE_F,
		STATE_G,
		STATE_H
	} state_t;
	
	state_t current_state, next_state;
	
	// Output logic
	always_ff @(posedge clk) begin
		if (!resetn) begin
			current_state <= STATE_A;
			f <= 0;
			g <= 0;
		end
		else begin
			current_state <= next_state;
			case (next_state)
				STATE_B: f <= 1;
				default: f <= 0;
			endcase
		end
	end
	
	// State transition logic
	always_comb begin
		next_state = current_state;
		case (current_state)
			STATE_A: begin
				if (resetn) 
					next_state = STATE_B;
				else
					next_state = STATE_A;
			end
			
			STATE_B: begin
				next_state = STATE_C;
			end
			
			STATE_C: begin
				if (x == 1)
					next_state = STATE_D;
				else
					next_state = STATE_C;
			end
			
			STATE_D: begin
				if (x == 0)
					next_state = STATE_E;
				else
					next_state = STATE_C;
			end
			
			STATE_E: begin
				if (x == 1)
					next_state = STATE_F;
				else
					next_state = STATE_C;
			end
			
			STATE_F: begin
				g = 1;
				if (y == 1)
					next_state = STATE_H;
				else
					next_state = STATE_G;
			end
			
			STATE_G: begin
				if (y == 1)
					next_state = STATE_H;
				else
					next_state = STATE_H; // Move to H after 2 cycles
			end

			STATE_H: begin
				if (y != 1)
					g = 0;
			end
			
			default: next_state = STATE_A;
		endcase
	end
	
endmodule
