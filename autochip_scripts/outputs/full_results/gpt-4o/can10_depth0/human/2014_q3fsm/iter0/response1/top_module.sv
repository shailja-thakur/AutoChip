module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State Declaration
	typedef enum reg [1:0] {A, B} state_t;
	state_t state, next_state;

	// Counter to track how many times w = 1
	reg [1:0] count;

	always @(posedge clk) begin
		if (reset) begin
			state <= A;         // reset state is A
			z <= 0;
			count <= 0;
		end else begin
			state <= next_state; // state transition
		end
	end

	// Next state logic and output logic
	always @(*) begin
		// Default assignments
		next_state = state;
		z = 0;

		case (state)
			A: begin
				if (s == 1)
					next_state = B;
				else
					next_state = A;
			end

			B: begin
				// Start counting w=1 for next 3 clock cycles
				if (count < 2'b11) begin
					if (w == 1) count = count + 1;
					if (count == 2'b10) z = 1;
					else z = 0;
				end else begin
					count = 0; // Reset count after each 3 cycles
				end
			end
		endcase
	end
endmodule
