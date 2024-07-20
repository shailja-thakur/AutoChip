module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// State declaration
	reg [2:0] state, next_state;

	// State encoding
	localparam A = 3'b000;
	localparam B = 3'b001;
	localparam C = 3'b010;
	localparam D = 3'b011;
	localparam E = 3'b100;

	// Sequential logic for state transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A; // Initialize to state A on reset
		end else begin
			state <= next_state; // Transition to the next state
		end
	end

	// Combinational logic for next state logic and output logic
	always @(*) begin
		// Default value of next_state to avoid latches
		next_state = state;
		z = 0; // Default output

		case (state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (x)
					next_state = E;
				else
					next_state = B;
			end
			C: begin
				if (x)
					next_state = B;
				else
					next_state = C;
			end
			D: begin
				if (x)
					next_state = C;
				else
					next_state = B;
			end
			E: begin
				if (x)
					next_state = E;
				else
					next_state = D;
			end
			default: next_state = A; // Default to state A if in an unknown state
		endcase

		// Output logic
		case (state)
			D, E: z = 1; // Output is high when in state D or E
			default: z = 0;
		endcase
	end

endmodule
