module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State definitions
	typedef enum logic [2:0] {
		state_A = 3'b000,
		state_B = 3'b001,
		state_C = 3'b010,
		state_D = 3'b011,
		state_E = 3'b100,
		state_F = 3'b101   // state for checking y
	} statetype;

	statetype state, next_state;

	// Counters
	reg [1:0] y_counter;

	// State Transition
	always_ff @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= state_A;
			f <= 1'b0;
			g <= 1'b0;
			y_counter <= 2'b0;
		end else begin
			state <= next_state;
			if (state == state_B) begin
				f <= 1'b1;
			end else begin
				f <= 1'b0;
			end
			if (state == state_F) begin
				g <= 1'b1;
				if (y) begin
					y_counter <= 2'b00;
				end else begin
					y_counter <= y_counter + 1;
					if (y_counter == 2'b10) begin
						g <= 1'b0;
					end
				end
			end
		end
	end

	// Next State Logic
	always_comb begin
		next_state = state; // Default state assignment to avoid latches
		case (state)
			state_A: begin
				if (resetn)
					next_state = state_B;
				else
					next_state = state_A;
			end

			state_B: begin
				next_state = state_C;
			end

			state_C: begin
				if (x)
					next_state = state_D;
				else
					next_state = state_C;
			end

			state_D: begin
				if (~x)
					next_state = state_E;
				else
					next_state = state_C;
			end

			state_E: begin
				if (x)
					next_state = state_F;
				else
					next_state = state_C;
			end

			state_F: begin
				if (!y && y_counter == 2'b10) begin
					next_state = state_A;
				end else begin
					next_state = state_F;
				end
			end

			default: begin
				next_state = state_A;
			end
		endcase
	end
endmodule
