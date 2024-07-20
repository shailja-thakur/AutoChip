module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State Enumeration
	typedef enum logic [1:0] {
		OFF = 2'b00,
		ON  = 2'b01
	} state_t;

	state_t state, next_state;

	// State Transition
	always_ff @(posedge clk) begin
		if (reset)
			state <= OFF;
		else
			state <= next_state;
	end

	// Next State Logic
	always_comb begin
		case (state)
			OFF: begin
				out = 1'b0;
				if (j)
					next_state = ON;
				else
					next_state = OFF;
			end
			
			ON: begin
				out = 1'b1;
				if (k)
					next_state = OFF;
				else
					next_state = ON;
			end
		endcase
	end

endmodule
