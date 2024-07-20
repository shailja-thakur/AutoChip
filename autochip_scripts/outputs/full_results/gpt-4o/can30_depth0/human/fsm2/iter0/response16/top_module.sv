module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	parameter OFF = 1'b0, ON = 1'b1;
	reg state, next_state;
	
	// State transition logic
	always @(*) begin
		case (state)
			OFF: next_state = j ? ON : OFF;
			ON: next_state = k ? OFF : ON;
			default: next_state = OFF;
		endcase
	end
	
	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= OFF;
		else
			state <= next_state;
	end
	
	// Output logic
	always @(*) begin
		case (state)
			OFF: out = 1'b0;
			ON: out = 1'b1;
			default: out = 1'b0;
		endcase
	end
	
endmodule
