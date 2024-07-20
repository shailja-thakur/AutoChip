module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	parameter S0 = 4'b0000,  // Initial state / No consecutive 1s
	          S1 = 4'b0001,  // 1 consecutive 1
	          S2 = 4'b0010,  // 2 consecutive 1s
	          S3 = 4'b0011,  // 3 consecutive 1s
	          S4 = 4'b0100,  // 4 consecutive 1s
	          S5 = 4'b0101,  // 5 consecutive 1s
	          S6 = 4'b0110,  // 6 consecutive 1s
	          S7 = 4'b0111,  // 7 consecutive 1s
	          S8 = 4'b1000;  // Error state

	// Current and next state variables
	reg [3:0] current_state, next_state;

	// Sequential logic for state transition
	always @(posedge clk) begin
		if (reset)
			current_state <= S0;  // Reset to initial state
		else
			current_state <= next_state;
	end

	// Combinational logic for next state and outputs
	always @(*) begin
		// Default outputs
		disc = 1'b0;
		flag = 1'b0;
		err = 1'b0;

		case (current_state)
			S0: begin
				if (in)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if (in)
					next_state = S2;
				else
					next_state = S0;
			end
			S2: begin
				if (in)
					next_state = S3;
				else
					next_state = S0;
			end
			S3: begin
				if (in)
					next_state = S4;
				else
					next_state = S0;
			end
			S4: begin
				if (in)
					next_state = S5;
				else
					next_state = S0;
			end
			S5: begin
				if (in)
					next_state = S6;
				else
					next_state = S0;
			end
			S6: begin
				if (in) begin
					next_state = S7;
				end else begin
					next_state = S0;
					flag = 1'b1;  // Flag detected
				end
			end
			S7: begin
				if (in) begin
					next_state = S8;
					err = 1'b1;  // Error detected
				end else begin
					next_state = S0;
					disc = 1'b1;  // Bit to discard after 5 consecutive 1s
				end
			end
			S8: begin
				err = 1'b1;  // Error state remains
				if (in)
					next_state = S8;  // Stay in error state
				else
					next_state = S0;
			end
			default: next_state = S0;
		endcase
		// Detect disc case
		if (current_state == S5 && !in)
			disc = 1'b1;
	end
endmodule
