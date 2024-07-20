module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State encoding
	typedef enum reg [3:0] {
		STATE_A = 4'd0,     // Initial state
		STATE_B = 4'd1,     // f = 1 for one clock cycle
		STATE_C = 4'd2,     // Monitor x for 1st '1'
		STATE_D = 4'd3,     // Monitor x for '0' after 1st '1'
		STATE_E = 4'd4,     // Monitor x for 2nd '1'
		STATE_F = 4'd5,     // Set g = 1 and monitor y
		STATE_G = 4'd6,     // g = 1 permanently
		STATE_H = 4'd7,     // g = 0 permanently if y not 1 in 2 cycles
		STATE_WAIT_Y1 = 4'd8,// Wait for y for 1st clock cycle
		STATE_WAIT_Y2 = 4'd9 // Wait for y for 2nd clock cycle
	} state_t;

	state_t state, next_state;

	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= STATE_A;
		else
			state <= next_state;
	end

	always @(*) begin
		f = 1'b0;
		g = 1'b0;
		next_state = state;
		case (state)
			STATE_A: begin
				next_state = STATE_B;
			end
			STATE_B: begin
				f = 1'b1;
				next_state = STATE_C;
			end
			STATE_C: begin
				if (x == 1'b1)
					next_state = STATE_D;
				else
					next_state = STATE_C;
			end
			STATE_D: begin
				if (x == 1'b0)
					next_state = STATE_E;
				else
					next_state = STATE_C;
			end
			STATE_E: begin
				if (x == 1'b1)
					next_state = STATE_F;
				else
					next_state = STATE_C;
			end
			STATE_F: begin
				g = 1'b1;
				next_state = STATE_WAIT_Y1;
			end
			STATE_WAIT_Y1: begin
				g = 1'b1;
				if (y == 1'b1)
					next_state = STATE_G;
				else
					next_state = STATE_WAIT_Y2;
			end
			STATE_WAIT_Y2: begin
				g = 1'b1;
				if (y == 1'b1)
					next_state = STATE_G;
				else
					next_state = STATE_H;
			end
			STATE_G: begin
				g = 1'b1;
				next_state = STATE_G;
			end
			STATE_H: begin
				g = 1'b0;
				next_state = STATE_H;
			end
			default: begin
				next_state = STATE_A;
			end
		endcase
	end
endmodule
