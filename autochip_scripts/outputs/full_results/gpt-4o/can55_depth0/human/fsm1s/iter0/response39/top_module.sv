module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum logic [1:0] {
		B = 2'b01,
		A = 2'b10
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			B: next_state = in ? B : A;
			A: next_state = in ? A : B;
			default: next_state = B;
		endcase
	end

	// State and output update logic
	always @(posedge clk) begin
		if (reset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	// Output logic based on the current state
	always @(*) begin
		case (state)
			B: out = 1;
			A: out = 0;
			default: out = 1;
		endcase
	end

endmodule
