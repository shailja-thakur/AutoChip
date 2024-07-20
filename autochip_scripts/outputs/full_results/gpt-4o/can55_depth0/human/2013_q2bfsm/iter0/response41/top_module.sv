module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State definition
	typedef enum reg [2:0] {
		State_A = 3'b000,
		State_B = 3'b001,
		State_C = 3'b010,
		State_D = 3'b011,
		State_E = 3'b100,
		State_F = 3'b101,
		State_G = 3'b110
	} state_t;

	state_t state, next_state;
	reg [1:0] counter; // Counter used to count clock cycles for y input

	always_ff @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= State_A;
			f <= 0;
			g <= 0;
			counter <= 0;
		end else begin
			state <= next_state;
			if (state == State_B) f <= 1;
			else f <= 0;
		end
	end

	always_comb begin
		next_state = state;
		case (state)
			State_A: begin
				if (~resetn) next_state = State_A;
				else next_state = State_B;
			end
			State_B: begin
				next_state = State_C;
			end
			State_C: begin
				if (x) next_state = State_D;
				else next_state = State_A;
			end
			State_D: begin
				if (~x) next_state = State_E;
				else next_state = State_A;
			end
			State_E: begin
				if (x) next_state = State_F;
				else next_state = State_A;
			end
			State_F: begin
				next_state = State_G;
			end
			State_G: begin
				g = 1;
				if (y) counter = 0;
				else counter = counter + 1;

				if (counter == 2'b10) begin
					if (y) begin
						counter = 0;
						g = 1;
					end else begin
						g = 0;
					end
					next_state = g ? State_A : State_A;
				end
			end
			default: next_state = State_A;
		endcase
	end
endmodule
