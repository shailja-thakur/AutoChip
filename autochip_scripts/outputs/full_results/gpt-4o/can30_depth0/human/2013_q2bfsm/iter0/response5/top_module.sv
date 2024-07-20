module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

typedef enum reg [2:0] {
	STATE_A,
	STATE_B,
	STATE_C,
	STATE_D,
	STATE_E,
	STATE_F
} state_t;
state_t state, next_state;

// State Register
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= STATE_A;
		f <= 0;
		g <= 0;
	end else begin
		state <= next_state;
	end
end

// Next State Logic
always @(*) begin
	case(state)
		STATE_A: begin
			f = 0;
			g = 0;
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
			if (x == 1) next_state = STATE_D;
			else next_state = STATE_C;
		end
		STATE_D: begin
			if (x == 0) next_state = STATE_E;
			else next_state = STATE_C;
		end
		STATE_E: begin
			if (x == 1) begin
				g = 1;
				next_state = STATE_F;
			end else begin
				next_state = STATE_C;
			end
		end
		STATE_F: begin
			if (y == 1) g = 1;
			else g = 0;
			next_state = STATE_F;
		end
		default: next_state = STATE_A;
	endcase
end

endmodule
