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
			   STATE_G = 4'd6;
	
	// State transition
	always @ (posedge clk) begin
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
				f = 1;
			end
			STATE_B: begin
				f = 1'b0;
				g = 1'b0;
				if (x == 1) 
					next_state = STATE_C;
			end
			STATE_C: begin
				f = 1'b0;
				g = 1'b0;
				if (x == 0)
					next_state = STATE_D;
			end
			STATE_D: begin
				f = 1'b0;
				g = 1'b0;
				if (x == 1) 
					next_state = STATE_E;
			end
			STATE_E: begin
				f = 1'b0;
				g = 1'b1;
				next_state = STATE_F;
			end
			STATE_F: begin
				f = 1'b0;
				if (y == 1) 
					next_state = STATE_G;
				else 
					next_state = STATE_E;
			end
			STATE_G: begin
				f = 1'b0;
				g = 1'b1;
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
			case (next_state)
				STATE_A: begin
					f <= 1'b0;
					g <= 1'b0;
				end
				STATE_B: f <= 1'b1;
				STATE_C: f <= 1'b0;
				STATE_D: f <= 1'b0;
				STATE_E: g <= 1'b1;
				STATE_F: g <= 1'b0;
				STATE_G: g <= 1'b1;
				default: begin
					f <= 1'b0;
					g <= 1'b0;
				end
			endcase
		end
	end
endmodule
