module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State encoding
	typedef enum reg [2:0] {
		A = 3'd0,
		B = 3'd1,
		C = 3'd2,
		D = 3'd3,
		E = 3'd4,
		F = 3'd5
	} state_t;

	state_t state, next_state;

	// State flip-flops
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// State transition logic
	always @(*) begin
		case (state)
			A: next_state = (w) ? B : A;
			B: next_state = (w) ? C : D;
			C: next_state = (w) ? E : D;
			D: next_state = (w) ? F : A;
			E: next_state = (w) ? E : D;
			F: next_state = (w) ? C : D;
			default: next_state = A; // Default state if an unknown state is encountered
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			A, B, C, D: z = 1'b0;
			E, F: z = 1'b1;
			default: z = 1'b0; // Default output if an unknown state is encountered
		endcase
	end

endmodule
