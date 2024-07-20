module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [2:0] {
		A = 3'b000,
		B = 3'b001,
		C = 3'b010,
		D = 3'b011,
		E = 3'b100
	} state_t;

	state_t state, next_state;

	// Sequential logic for state transition
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A; // Initialize to state A on reset
		else
			state <= next_state;
	end

	// Combinational logic for next state generation
	always @(*) begin
		case (state)
			A: next_state = (x) ? B : A;
			B: next_state = (x) ? E : B;
			C: next_state = (x) ? B : C;
			D: next_state = (x) ? C : B;
			E: next_state = (x) ? E : D;
			default: next_state = A; // Default case (should not occur)
		endcase
	end

	// Combinational logic for output generation
	always @(*) begin
		case (state)
			D, E: z = 1'b1;
			default: z = 1'b0;
		endcase
	end

endmodule
