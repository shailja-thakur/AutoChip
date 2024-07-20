module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State Encodings
	reg state, next_state;
	parameter OFF = 1'b0;
	parameter ON = 1'b1;
	
	// State Transition
	always @(posedge clk) begin
		if (reset)
			state <= OFF;
		else
			state <= next_state;
	end
	
	// Next State Logic
	always @(*) begin
		case (state)
			OFF: begin
				if (j)
					next_state = ON;
				else
					next_state = OFF;
			end
			ON: begin
				if (k)
					next_state = OFF;
				else
					next_state = ON;
			end
			default: next_state = OFF;
		endcase
	end
	
	// Output Logic
	always @(posedge clk) begin
		if (reset)
			out <= 1'b0;
		else
			out <= (state == ON) ? 1'b1 : 1'b0;
	end

endmodule
