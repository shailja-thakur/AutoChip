module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	reg state, next_state;
	localparam OFF = 1'b0,
	           ON  = 1'b1;

	// State Transition on Clock Edge
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= OFF;
		else
			state <= next_state;
	end

	// Next State Logic
	always @(*) begin
		case (state)
			OFF: next_state = j ? ON : OFF;
			ON:  next_state = k ? OFF : ON;
			default: next_state = OFF;
		endcase
	end

	// Output logic (Moore machine: output depends only on state)
	always @(posedge clk or posedge areset) begin
		if (areset)
			out <= 1'b0;
		else
			out <= (state == ON) ? 1'b1 : 1'b0;
	end

endmodule
