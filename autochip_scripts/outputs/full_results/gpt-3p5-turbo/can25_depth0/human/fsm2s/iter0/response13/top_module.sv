module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// declare states
	typedef enum logic [1:0] {
		OFF,
		ON
	} state_t;

	reg state, next_state;

	// synchronous reset
	always_ff @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= OFF;
		else
			state <= next_state;
	end

	// combinatorial logic
	always_comb
	begin
		case (state)
			OFF:
				begin
					if (j) // transition from OFF to ON
						next_state = ON;
					else
						next_state = OFF;
				end
			
			ON:
				begin
					if (k) // transition from ON to OFF
						next_state = OFF;
					else
						next_state = ON;
				end
		endcase
	end

	// output assignment based on state
	always_comb
	begin
		case (state)
			OFF: out = 0;
			ON: out = 1;
		endcase
	end
endmodule
