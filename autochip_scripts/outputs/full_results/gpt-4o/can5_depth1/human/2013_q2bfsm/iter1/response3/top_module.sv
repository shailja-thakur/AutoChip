module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [3:0] state, next_state;

	// States
	localparam STATE_A = 4'd0,
			   STATE_B = 4'd1,
			   STATE_C = 4'd2,
			   STATE_D = 4'd3,
			   STATE_E = 4'd4,
			   STATE_F = 4'd5,
			   STATE_G = 4'd6,
			   STATE_H = 4'd7,
			   STATE_I = 4'd8;
	
	// State transition
	always @ (posedge clk or negedge resetn) begin
		if (!resetn)
			state <= STATE_A;
		else
			state <= next_state;
	end

	// Next state logic
	always @ (*) begin
		next_state = state;
		case (state)
			STATE_A: begin
				f = 0;
				g = 0;
				if (resetn) 
					next_state = STATE_B;
			end
			STATE_B: begin
				f = 1;
				g = 0;
				next_state = STATE_C;
			end
			STATE_C: begin
				f = 0;
				g = 0;
				if (x == 1) 
					next_state = STATE_D;
				else 
					next_state = STATE_B;
			end
			STATE_D: begin
				f = 0;
				g = 0;
				if (x == 0) 
					next_state = STATE_E;
				else 
					next_state = STATE_B;
			end
			STATE_E: begin
				f = 0;
				g = 0;
				if (x == 1) 
					next_state = STATE_F;
				else 
					next_state = STATE_B;
			end
			STATE_F: begin
				f = 0;
				g = 1;
				next_state = STATE_G;
			end
			STATE_G: begin
				f = 0;
				g = 1;
				if (y == 1) 
					next_state = STATE_I;
				else 
					next_state = STATE_H;
			end
			STATE_H: begin
				f = 0;
				g = 1;
				if (y == 1) 
					next_state = STATE_I;
				else 
					next_state = STATE_A;
			end
			STATE_I: begin
				f = 0;
				g = 1;
			end
			default: next_state = STATE_A;
		endcase
	end

	// Output logic
	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 0;
			g <= 0;
		end else begin
			case (state)
				STATE_A: begin
					f <= 0;
					g <= 0;
				end
				STATE_B: f <= 1;
				STATE_C: f <= 0;
				STATE_D: f <= 0;
				STATE_E: f <= 0;
				STATE_F: g <= 1;
				STATE_G: g <= 1;
				STATE_H: g <= 1;
				STATE_I: g <= 1;
				default: begin
					f <= 0;
					g <= 0;
				end
			endcase
		end
	end
endmodule
