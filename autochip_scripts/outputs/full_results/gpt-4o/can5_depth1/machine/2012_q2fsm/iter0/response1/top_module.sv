module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	
	// Define state encoding
	typedef enum reg [2:0] {
		A = 3'b000,
		B = 3'b001,
		C = 3'b010,
		D = 3'b011,
		E = 3'b100,
		F = 3'b101
	} state_t;
	
	// State register
	reg [2:0] state, next_state;
	
	// Synchronous block to update state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A; // Initial state on reset
		else
			state <= next_state;
	end
	
	// Combinational block for next state logic
	always @(*) begin
		case (state)
			A: next_state = (w == 1) ? B : A;
			B: next_state = (w == 1) ? C : D;
			C: next_state = (w == 1) ? E : D;
			D: next_state = (w == 1) ? F : A;
			E: next_state = (w == 1) ? E : D;
			F: next_state = (w == 1) ? C : D;
			default: next_state = A; // Default to A state
		endcase
	end
	
	// Output logic
	always @(*) begin
		case (state)
			E, F: z = 1;
			default: z = 0;
		endcase
	end
	
endmodule
