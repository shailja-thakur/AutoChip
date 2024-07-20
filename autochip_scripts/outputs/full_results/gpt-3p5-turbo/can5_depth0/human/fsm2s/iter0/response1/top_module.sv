module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	// Define states
	parameter OFF = 0;
	parameter ON = 1;

	// Define current state and next state variables
	reg [1:0] state, next_state;

	// Define output variable
	reg out;

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end

	// Define next state and output logic
	always @* begin
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
		endcase

		// Output logic
		case (state)
			OFF: out = 0;
			ON: out = 1;
		endcase
	end

endmodule
