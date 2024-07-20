module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [2:0] state, next_state;
	reg [1:0] y_counter;

	// States
	localparam STATE_A = 3'd0,
			   STATE_B = 3'd1,
			   STATE_C = 3'd2,
			   STATE_D = 3'd3,
			   STATE_E = 3'd4,
			   STATE_F = 3'd5,
			   STATE_G = 3'd6;
	
	// State transition
	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= STATE_A;
			y_counter <= 2'd0;
		end else
			state <= next_state;
	end

	// Next state logic
	always @ (*) begin
		next_state = state;
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
			end
			STATE_C: begin
				if (x == 0)
					next_state = STATE_D;
			end
			STATE_D: begin
				if (x == 1) 
					next_state = STATE_E;
			end
			STATE_E: begin
				next_state = STATE_F;
			end
			STATE_F: begin
				if (y == 1) 
					next_state = STATE_G;
				else if (y_counter == 2'd1)
					next_state = STATE_A;
			end
			STATE_G: begin
				next_state = STATE_G;
			end
			default: next_state = STATE_A;
		endcase
	end

	// Output and counter logic
	always @ (posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 1'b0;
			g <= 1'b0;
			y_counter <= 2'd0;
		end else begin
			case (state)
				STATE_A: begin
					f <= 1'b0;
					g <= 1'b0;
				end
				STATE_B: f <= 1'b1;
				STATE_C: f <= 1'b0;
				STATE_D: f <= 1'b0;
				STATE_E: g <= 1'b1;
				STATE_F: begin
					if (y == 1) 
						g <= 1'b1;
					else if (y_counter == 2'd1) 
						g <= 1'b0;
					else
						y_counter <= y_counter + 1;
				end
				STATE_G: g <= 1'b1;
				default: begin
					f <= 1'b0;
					g <= 1'b0;
					y_counter <= 2'd0;
				end
			endcase
		end
	end
endmodule
