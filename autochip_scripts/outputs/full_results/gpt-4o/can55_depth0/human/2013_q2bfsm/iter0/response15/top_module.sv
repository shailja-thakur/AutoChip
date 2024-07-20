module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State Declaration
	typedef enum logic [2:0] {
		STATE_A,
		STATE_B,
		STATE_C,
		STATE_D,
		STATE_E,
		STATE_F,
		STATE_G
	} state_t;
	
	state_t state, next_state;
	
	// Output Logic
	always @ (posedge clk or negedge resetn) begin
		if (!resetn)
			state <= STATE_A;
		else
			state <= next_state;
	end
	
	// Next State Logic
	always @ (*) begin
		next_state = state;
		f = 0;
		case (state)
			STATE_A: begin
				next_state = STATE_B;
			end
			STATE_B: begin
				f = 1;
				next_state = STATE_C;
			end
			STATE_C: begin
				if (x == 1'b1)
					next_state = STATE_D;
			end
			STATE_D: begin
				if (x == 1'b0)
					next_state = STATE_E;
			end
			STATE_E: begin
				if (x == 1'b1)
					next_state = STATE_F;
			end
			STATE_F: begin
				g = 1;
				next_state = STATE_G;
			end
			STATE_G: begin
				if (y == 1'b1)
					g = 1;
				else if (y == 1'b0)
					g = 1;
				else
					g = 0;
			end
			default: next_state = STATE_A;
		endcase
	end
	
	// Output Regeneration
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 0;
			g <= 0;
		end else begin
			case (state)
				STATE_B: f <= 1;
				STATE_F: g <= 1;
				STATE_G: begin
					if (y == 1'b1)
						g <= 1;
					else if (y == 1'b0)
						g <= 1;
					else
						g <= 0;
				end
				default: begin
					f <= 0;
					g <= 0;
				end
			endcase
		end
	end
endmodule
