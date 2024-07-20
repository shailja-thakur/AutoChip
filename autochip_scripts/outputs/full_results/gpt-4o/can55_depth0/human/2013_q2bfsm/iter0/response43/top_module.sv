module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State encoding
	typedef enum logic [2:0] {
		STATE_A = 3'b000,  // Beginning state
		STATE_B = 3'b001,  // Set f = 1 for one clock cycle
		STATE_C = 3'b010,  // Monitor x for 101 sequence
		STATE_D = 3'b011,  // Set g = 1, monitor y
		STATE_E = 3'b100,  // g = 1 permanently
		STATE_F = 3'b101   // g = 0 permanently
	} state_t;

	state_t current_state, next_state;

	// State transition
	always_ff @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= STATE_A;
		else
			current_state <= next_state;
	end

	// State output and next state logic
	always_comb begin
		// Default values
		next_state = current_state;
		f = 0;
		g = 0;

		case (current_state)
			STATE_A: begin
				if (resetn) begin
					next_state = STATE_B;
				end
			end

			STATE_B: begin
				f = 1;
				next_state = STATE_C;
			end

			STATE_C: begin
				if ({x, x_d1, x_d2} == 3'b101) begin
					next_state = STATE_D;
				end
			end

			STATE_D: begin
				g = 1;
				if (y_d1 || y_d2)
					next_state = STATE_E;
				else
					next_state = STATE_F;
			end

			STATE_E: begin
				g = 1;
			end

			STATE_F: begin
				g = 0;
			end

			default: begin
				next_state = STATE_A;
			end
		endcase
	end

	// Delay elements for x and y inputs
	reg x_d1, x_d2;
	reg y_d1, y_d2;

	always_ff @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			x_d1 <= 0;
			x_d2 <= 0;
			y_d1 <= 0;
			y_d2 <= 0;
		end else begin
			x_d1 <= x;
			x_d2 <= x_d1;
			y_d1 <= y;
			y_d2 <= y_d1;
		end
	end

endmodule
