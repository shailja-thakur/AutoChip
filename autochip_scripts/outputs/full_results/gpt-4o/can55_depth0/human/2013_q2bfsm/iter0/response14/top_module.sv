module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	typedef enum reg [2:0] {
		STATE_A = 3'b000,
		STATE_B = 3'b001,
		STATE_C = 3'b010,
		STATE_D = 3'b011,
		STATE_E = 3'b100,
		STATE_F = 3'b101,
		STATE_G = 3'b110
	} state_t;

	state_t state, next_state;
	reg [1:0] y_test_counter;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= STATE_A;
			f <= 0;
			g <= 0;
			y_test_counter <= 0;
		end else begin
			state <= next_state;

			// Handle f and g setting according to the state
			case (state)
				STATE_A: f <= 0;
				STATE_B: f <= 1; // f is set to 1 for one clock cycle
				STATE_C, STATE_D, STATE_E, STATE_F, STATE_G: f <= 0;
				default: f <= 0;
			endcase

			if (state == STATE_G && y_test_counter == 0 && y == 1) begin
				g <= 1; // maintain g = 1 permanently
			end else if (state == STATE_G && y_test_counter == 2 && y != 1) begin
				g <= 0; // set g = 0 permanently after two clock cycles
			end
		end
	end

	always @(*) begin
		next_state = state;
		case (state)
			STATE_A: begin
				if (resetn) begin
					next_state = STATE_A;
				} else begin
					next_state = STATE_B;
				end
			end
			STATE_B: begin
				next_state = STATE_C;
			end
			STATE_C: begin
				if (x) next_state = STATE_D;
				else next_state = STATE_C;
			end
			STATE_D: begin
				if (!x) next_state = STATE_E;
				else next_state = STATE_D;
			end
			STATE_E: begin
				if (x) next_state = STATE_F;
				else next_state = STATE_C;
			end
			STATE_F: begin
				next_state = STATE_G;
			end
			STATE_G: begin
				if (y_test_counter < 2 && y != 1) begin
					y_test_counter = y_test_counter + 1;
				end else begin
					y_test_counter = 0;
				end
				next_state = STATE_G; // remain in STATE_G for further checking
			end
		endcase
	end

endmodule
