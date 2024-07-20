module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [2:0] state, next_state;

	// States
	localparam STATE_A = 3'd0,
			   STATE_B = 3'd1,
			   STATE_C = 3'd2,
			   STATE_D = 3'd3,
			   STATE_E = 3'd4,
			   STATE_F = 3'd5,
			   STATE_G = 3'd6,
			   STATE_H = 3'd7;

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
				f = 1'b0;
				g = 1'b0;
				if (!resetn) 
					next_state = STATE_A;
				else 
					next_state = STATE_B;
			end
			STATE_B: begin
				f = 1'b1;      // f is set to 1 for one clock cycle
				g = 1'b0;
				next_state = STATE_C;
			end
			STATE_C: begin
				f = 1'b0;
				g = 1'b0;
				if (x == 1) 
					next_state = STATE_D;
			end
			STATE_D: begin
				f = 1'b0;
				g = 1'b0;
				if (x == 0) 
					next_state = STATE_E;
			end
			STATE_E: begin
				f = 1'b0;
				g = 1'b0;
				if (x == 1) 
					next_state = STATE_F;
			end
			STATE_F: begin
				f = 1'b0;
				g = 1'b1;
				next_state = STATE_G;
			end
			STATE_G: begin
				f = 1'b0;
				if (y == 1) 
					next_state = STATE_H;
				else
					next_state = STATE_H;
			end
			STATE_H: begin
				g = g;
				next_state = state;
				if (y != 1) next_state = STATE_A;
				
			end
			default: next_state = STATE_A;
		endcase
	end

	// Output logic
	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 1'b0;
			g <= 1'b0;
		end else begin
			case (state)
				STATE_A: begin
					f <= 1'b0;
					g <= 1'b0;
				end
				STATE_B: f <= 1'b1;
				STATE_C: f <= 1'b0;
				STATE_D: f <= 1'b0;
				STATE_E: f <= 1'b0;
				STATE_F: g <= 1'b1;
				STATE_G: g <= 1'b0;
				STATE_H: g <= (y == 1) ? 1'b1 : 1'b0;
				default: begin
					f <= 1'b0;
					g <= 1'b0;
				end
			endcase
		end
	end
endmodule
