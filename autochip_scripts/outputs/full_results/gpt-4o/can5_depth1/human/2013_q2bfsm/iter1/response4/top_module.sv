module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [3:0] state, next_state;
	reg [1:0] y_counter;
	reg f_pulse; 

	// States
	localparam STATE_A = 4'd0,
			   STATE_B = 4'd1,
			   STATE_C = 4'd2,
			   STATE_D = 4'd3,
			   STATE_E = 4'd4,
			   STATE_F = 4'd5,
			   STATE_G = 4'd6;
	
	// State transition
	always @ (posedge clk or negedge resetn) begin
		if (!resetn)
			state <= STATE_A;
		else
			state <= next_state;
	end

	// Next state logic
	always @ (*) begin
		case (state)
			STATE_A: begin
				if (!resetn) 
					next_state = STATE_A;
				else 
					next_state = STATE_B;
			end
			STATE_B: begin
				if (x == 1) 
					next_state = STATE_C;
				else
					next_state = STATE_B;
			end
			STATE_C: begin
				if (x == 0)
					next_state = STATE_D;
				else
					next_state = STATE_C;
			end
			STATE_D: begin
				if (x == 1) 
					next_state = STATE_E;
				else
					next_state = STATE_D;
			end
			STATE_E: begin
				next_state = STATE_F;
			end
			STATE_F: begin
				if (y == 1) 
					next_state = STATE_G;
				else if (y_counter >= 2)
					next_state = STATE_A;
				else
					next_state = STATE_F;
			end
			STATE_G: begin
				next_state = STATE_G;
			end
			default: next_state = STATE_A;
		endcase
	end

	// Output logic and counters
	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 1'b0;
			g <= 1'b0;
			y_counter <= 0;
			f_pulse <= 0;
		end else begin
			case (next_state)
				STATE_A: begin
					f <= 1'b0;
					g <= 1'b0;
					y_counter <= 0;
					f_pulse <= 0;
				end
				STATE_B: begin
					if(state == STATE_A)
						f <= 1'b1;
					else
						f <= 1'b0;
				end
				STATE_C: f <= 1'b0;
				STATE_D: f <= 1'b0;
				STATE_E: begin
					if(!f_pulse) begin
						f <= 1'b1;
						f_pulse <= 1;
					end else begin
						f <= 1'b0;
					end
					g <= 1'b1;
				end
				STATE_F: begin
					f <= 1'b0;
					if(state == STATE_E) y_counter <= 0;
					else if (y != 1) y_counter <= y_counter + 1;
					if (y_counter >= 2) g <= 0;
					else g <= 1;
				end
				STATE_G: g <= 1'b1;
				default: begin
					f <= 1'b0;
					g <= 1'b0;
					y_counter <= 0;
					f_pulse <= 0;
				end
			endcase
		end
	end
endmodule
