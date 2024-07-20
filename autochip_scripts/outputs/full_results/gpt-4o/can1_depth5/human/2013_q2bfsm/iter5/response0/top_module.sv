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
		state_A = 3'b000,  // Start state, also go back here on reset
		state_B = 3'b001,  // Set f = 1 for one cycle
		state_C = 3'b010,  // Wait for x == 1
		state_D = 3'b011,  // Wait for x == 0
		state_E = 3'b100,  // Wait for x == 1 (with previous x == 0)
		state_F = 3'b101,  // Set g = 1 and start checking y
		state_G = 3'b110,  // Wait for y == 1 or timeout
		state_H = 3'b111   // g = 0 permanently (until reset)
	} statetype;

	statetype state, next_state;

	// Control signal for f (pulse for one clk cycle)
	reg f_set;
	wire reset = !resetn;

	// Counters
	reg [1:0] y_counter;

	// State Transition
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= state_A;
			f <= 1'b0;
			g <= 1'b0;
			y_counter <= 2'b0;
		end else begin
			state <= next_state;
			
			// Control f and g based on state
			case (state)
				state_A: begin
					f <= 1'b0;
					f_set <= 1'b0;
					g <= 1'b0;
					y_counter <= 2'b0;
				end
				state_B: begin
					if (!f_set) begin
						f <= 1'b1;
						f_set <= 1'b1;
					end else begin
						f <= 1'b0;
					end
				end
				state_C, state_D, state_E: begin
					f <= 1'b0;
				end
				state_F: begin
					g <= 1'b1;
					y_counter <= 2'b00;
				end
				state_G: begin
					if (y) begin
						g <= 1'b1;
					end else if (y_counter == 2'b10) begin
						g <= 1'b0;
					end
					// Increment y_counter within state_G as long as y is 0
					if (!y && y_counter < 2'b10) begin
						y_counter <= y_counter + 1;
					end
				end
				state_H: begin
					g <= 1'b0;
				end
				default: begin
					f <= 1'b0;
					g <= 1'b0;
				end
			endcase
		end
	end

	// Next State Logic
	always_comb begin
		next_state = state; // Default state assignment to avoid latches
		case (state)
			state_A: begin
				if (resetn)
					next_state = state_B;
			end
			state_B: begin
				next_state = state_C;
			end
			state_C: begin
				if (x)
					next_state = state_D;
			end
			state_D: begin
				if (~x)
					next_state = state_E;
			end
			state_E: begin
				if (x)
					next_state = state_F;
			end
			state_F: begin
				next_state = state_G;
			end
			state_G: begin
				if (y)
					next_state = state_G;  // Stay in state_G if y becomes 1 (permanently)
				else if (y_counter == 2'b10)
					next_state = state_H;  // Move to state_H if y did not become 1 for two cycles
			end
			state_H: begin
				if (!resetn)
					next_state = state_A;  // Go back to state_A only on reset
			end
			default: begin
				next_state = state_A;
			end
		endcase
	end
endmodule
