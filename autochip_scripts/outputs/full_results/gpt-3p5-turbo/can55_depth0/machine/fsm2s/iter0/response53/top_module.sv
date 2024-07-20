module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	reg state, next_state;

	// Initial state assignment
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			0: begin // State A
				if (j)
					next_state = 1; // Transition to state B if j is high
				else
					next_state = 0; // Stay in state A if j is low
			end
			
			1: begin // State B
				if (k)
					next_state = 0; // Transition to state A if k is high
				else
					next_state = 1; // Stay in state B if k is low
			end
		endcase
	end

	// Output assignment
	assign out = (state == 1) ? 1'b1 : 1'b0; // Output is high when state is B, low when state is A
endmodule
