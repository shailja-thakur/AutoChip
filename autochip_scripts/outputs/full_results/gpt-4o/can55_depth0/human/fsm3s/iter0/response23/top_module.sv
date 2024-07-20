module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg [1:0] {
		S_A = 2'b00,
		S_B = 2'b01,
		S_C = 2'b10,
		S_D = 2'b11
	} state_t;

	// State registers
	state_t current_state, next_state;

	// Synchronous state transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= S_A;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (current_state)
			S_A: next_state = in ? S_B : S_A;
			S_B: next_state = in ? S_B : S_C;
			S_C: next_state = in ? S_D : S_A;
			S_D: next_state = in ? S_B : S_C;
			default: next_state = S_A;
		endcase
	end

	// Output logic
	always @(*) begin
		case (current_state)
			S_A: out = 1'b0;
			S_B: out = 1'b0;
			S_C: out = 1'b0;
			S_D: out = 1'b1;
			default: out = 1'b0;
		endcase
	end

endmodule
