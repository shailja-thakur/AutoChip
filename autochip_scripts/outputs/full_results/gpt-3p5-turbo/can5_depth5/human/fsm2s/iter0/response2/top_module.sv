module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// Define the states
	typedef enum logic [1:0] {
		OFF,
		ON
	} state_t;

	// Define the state register and initialize it to OFF
	state_t state, next_state;
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end

	// Define the outputs based on the current state
	always_comb begin
		case (state)
			OFF: out = 0;
			ON: out = 1;
		endcase
	end

	// Define the next state logic
	always_comb begin
		case (state)
			OFF: begin
				if (j == 1) begin
					next_state = ON;
				end else begin
					next_state = OFF;
				end
			end
			ON: begin
				if (k == 0) begin
					next_state = ON;
				end else begin
					next_state = OFF;
				end
			end
		endcase
	end

endmodule
