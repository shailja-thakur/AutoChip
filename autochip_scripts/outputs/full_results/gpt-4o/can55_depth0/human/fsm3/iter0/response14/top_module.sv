module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Declare state encoding
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;

	state_t current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
			A: next_state = in ? B : A;
			B: next_state = in ? B : C;
			C: next_state = in ? D : A;
			D: next_state = in ? B : C;
			default: next_state = A; // Should never reach here
		endcase
	end

	// State register with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (current_state)
			A: out = 1'b0;
			B: out = 1'b0;
			C: out = 1'b0;
			D: out = 1'b1;
			default: out = 1'b0; // Should never reach here
		endcase
	end

endmodule
