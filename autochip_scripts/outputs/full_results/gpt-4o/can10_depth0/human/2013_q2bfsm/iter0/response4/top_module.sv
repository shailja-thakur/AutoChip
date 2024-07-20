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
		S_A = 3'b000,
		S_B = 3'b001,
		S_C = 3'b010,
		S_D = 3'b011,
		S_E = 3'b100,
		S_F = 3'b101
	} state_t;

	state_t current_state, next_state;

	// State register
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			current_state <= S_A;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		next_state = current_state; // Default to current state
		f = 0;
		g = 0;

		case (current_state)
			S_A: begin
				if (!resetn) begin
					next_state = S_B;
				end
			end
			S_B: begin
				f = 1;
				next_state = S_C;
			end
			S_C: begin
				if (x == 1) begin
					next_state = S_D;
				end
			end
			S_D: begin
				if (x == 0) begin
					next_state = S_E;
				end else begin
					next_state = S_C; // Go back to S_C if x is not 0
				end
			end
			S_E: begin
				if (x == 1) begin
					g = 1;
					next_state = S_F;
				end else begin
					next_state = S_C; // Go back to S_C if x is not 1
				end
			end
			S_F: begin
				g = 1;
				if (y == 1) begin
					next_state = S_F; // Stay in S_F if y is 1
				end else begin
					next_state = S_A; // Return to S_A if y is not 1 within two clock cycles
				end
			end
			default: begin
				next_state = S_A;
			end
		endcase
	end

	// Output logic
	always @(current_state or resetn) begin
		if (!resetn) begin
			f = 0;
			g = 0;
		end else begin
			case (current_state)
				S_B: f = 1;
				S_F: g = 1;
			endcase
		end
	end

endmodule
