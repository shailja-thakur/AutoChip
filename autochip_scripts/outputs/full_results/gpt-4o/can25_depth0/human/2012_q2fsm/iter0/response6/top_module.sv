module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State Encoding
	typedef enum reg [2:0] {
		A = 3'b000,
		B = 3'b001,
		C = 3'b010,
		D = 3'b011,
		E = 3'b100,
		F = 3'b101
	} state_t;
	
	state_t state, next_state;

	// State Flip-Flops (Sequential Logic)
	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= A; // Reset to state A
		else 
			state <= next_state;
	end

	// State Table (Combinational Logic)
	always @(*) begin
		case (state)
			A: next_state = (w) ? B : A;
			B: next_state = (w) ? C : D;
			C: next_state = (w) ? E : D;
			D: next_state = (w) ? F : A;
			E: next_state = (w) ? E : D;
			F: next_state = (w) ? C : D;
			default: next_state = A;
		endcase
	end

	// Output Logic (Combinational Logic)
	always @(*) begin
		case (state)
			A: z = 0;
			B: z = 0;
			C: z = 0;
			D: z = 0;
			E: z = 1;
			F: z = 1;
			default: z = 0;
		endcase
	end

endmodule
