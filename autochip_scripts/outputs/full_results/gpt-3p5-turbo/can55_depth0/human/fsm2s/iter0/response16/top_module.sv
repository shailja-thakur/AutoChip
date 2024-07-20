module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// State enumeration
	parameter OFF = 0;
	parameter ON = 1;

	// State register and next state register
	reg [1:0] state;
	reg [1:0] next_state;

	// Output register
	reg out;

	// Sequential logic on positive edge of clock
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset state to OFF
			state <= OFF;
		end else begin
			// Update state based on next state
			state <= next_state;
		end
	end

	// Combinational logic
	always @* begin
		case (state)
			OFF: begin
				if (j) begin
					// Transition to ON state
					next_state = ON;
				end else begin
					// Stay in OFF state
					next_state = OFF;
				end
				
				// Output is always 0
				out = 0;
			end
			ON: begin
				if (k) begin
					// Transition to OFF state
					next_state = OFF;
				end else begin
					// Stay in ON state
					next_state = ON;
				end
				
				// Output is always 1
				out = 1;
			end
		endcase
	end

endmodule
