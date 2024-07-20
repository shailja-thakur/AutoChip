module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// Define states as local parameters
	localparam A = 3'b000,
	           B = 3'b001,
	           C = 3'b010,
	           D = 3'b011,
	           E = 3'b100;

	// Variable to hold the current state and the next state
	reg [2:0] state, next_state;

	// State transition logic
	always @(*) begin
		case(state)
			A: if (x) next_state = B; else next_state = A;
			B: if (x) next_state = E; else next_state = B;
			C: if (x) next_state = B; else next_state = C;
			D: if (x) next_state = C; else next_state = B;
			E: if (x) next_state = E; else next_state = D;
			default: next_state = A;
		endcase
	end

	// Sequential logic to update state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			D, E: z = 1;
			default: z = 0;
		endcase
	end
endmodule
