module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State Definitions
	typedef enum logic [2:0] {
		STATE_A = 3'b000,
		STATE_B = 3'b001,
		STATE_C = 3'b010,
		STATE_D = 3'b011,
		STATE_E = 3'b100,
		STATE_F = 3'b101,
		STATE_G = 3'b110
	} state_t;

	state_t state, next_state;
	logic [1:0] y_count;

	// State Transition
	always_ff @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= STATE_A;
			f <= 0;
			g <= 0;
		end else begin
			state <= next_state;
			if (state == STATE_B)
				f <= 1;
			else
				f <= 0;
		end
	end
	
	// Next State Logic with Outputs
	always_comb begin
		next_state = state;
		case (state)
			STATE_A: begin
				if (resetn == 1) begin
					next_state = STATE_B;
				end
			end
			STATE_B: begin
				next_state = STATE_C;
			end
			STATE_C: begin
				if (x == 1)
					next_state = STATE_D;
			end
			STATE_D: begin
				if (x == 0)
					next_state = STATE_E;
			end
			STATE_E: begin
				if (x == 1)
					next_state = STATE_F;
			end
			STATE_F: begin
				g = 1;
				next_state = STATE_G;
				y_count = 2'd0;
			end
			STATE_G: begin
				if (y == 1)
					g = 1;
				else if (y_count == 2'd2)
					g = 0;
				else
					y_count = y_count + 2'd1;
			end
			default: begin
				next_state = STATE_A;
			end
		endcase
	end

endmodule
