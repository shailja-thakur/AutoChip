module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// Create signals for the states
	reg [1:0] current_state, next_state;

	// Initialize the current state to state A
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= 2'b0;
		else
			current_state <= next_state;
	end

	// Determine the next state based on the current state and inputs
	always @* begin
		case (current_state)
			2'b00: begin
				if (j)
					next_state = 2'b01;
				else
					next_state = current_state;
			end
			2'b01: begin
				if (k)
					next_state = 2'b00;
				else
					next_state = current_state;
			end
			default: next_state = current_state;
		endcase
	end

	// Set output based on the current state
	assign out = (current_state == 2'b01) ? 1'b1 : 1'b0;

endmodule
