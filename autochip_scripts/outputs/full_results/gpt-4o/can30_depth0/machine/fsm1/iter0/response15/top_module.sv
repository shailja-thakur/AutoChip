module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {A=1'b0, B=1'b1} state_t;
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case(state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
		endcase
	end

	// State update logic (sequential)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			out <= 1'b1;
		else
			out <= (state == B) ? 1'b1 : 1'b0;
	end

endmodule
