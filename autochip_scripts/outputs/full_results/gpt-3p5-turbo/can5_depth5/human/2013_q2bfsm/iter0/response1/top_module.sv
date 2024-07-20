module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	// Define states
	typedef enum logic [1:0] {
		STATE_A,
		STATE_B,
		STATE_C,
		STATE_D,
		STATE_E
	} state_t;

	// State register
	reg state_t current_state, next_state;

	// Outputs
	reg f_reg, g_reg;

	// Initialize state and outputs
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			current_state <= STATE_A;
			f_reg <= 0;
			g_reg <= 0;
		end else begin
			current_state <= next_state;
			f_reg <= 0;
			g_reg <= g_reg;
		end
	end

	// Next state logic and output control
	always @(*) begin
		next_state = current_state;
		f = f_reg;
		g = g_reg;

		case (current_state)
			STATE_A: begin
				f = 0;
				g = 0;
				if (resetn && (x == 1'b1) && (y == 1'b1))
					next_state = STATE_B;
			end

			STATE_B: begin
				f = 1;
				if (resetn)
					next_state = STATE_C;
			end

			STATE_C: begin
				if (resetn)
					next_state = STATE_D;
			end

			STATE_D: begin
				if (resetn && (x == 1'b1))
					next_state = STATE_E;
			end

			STATE_E: begin
				g = 1;
				if (resetn && (x == 1'b1))
					next_state = STATE_E;
				else if (resetn && (y == 1'b1))
					next_state = STATE_E;
				else if (resetn)
					next_state = STATE_D;
			end
		endcase
	end

	// Assign outputs after state update
	always @(*) begin
		f_reg = f;
		g_reg = g;
	end

endmodule
