module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	parameter S0 = 3'b000,  // Initial state / No consecutive 1s
	          S1 = 3'b001,  // 1 consecutive 1
	          S2 = 3'b010,  // 2 consecutive 1s
	          S3 = 3'b011,  // 3 consecutive 1s
	          S4 = 3'b100,  // 4 consecutive 1s
	          S5 = 3'b101,  // 5 consecutive 1s
	          S6 = 3'b110,  // 6 consecutive 1s
	          S7 = 3'b111;  // 7 or more consecutive 1s => Error

	// Current and next state variables
	reg [2:0] current_state, next_state;

	// Sequential logic for state transition
	always @(posedge clk) begin
		if (reset) begin
			current_state <= S0;  // Reset to initial state
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
		end else begin
			current_state <= next_state;
			// Update outputs based on current state
			disc <= (current_state == S6 && !in);
			flag <= (current_state == S6 && !in);
			err <= (current_state == S7);
		end
	end

	// Combinational logic for next state
	always @(*) begin
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
				if (in)
					next_state = S7;
				else
					next_state = S0;
			end
			S7: begin
				if (in)
					next_state = S7;
				else
					next_state = S0;
			end
			default: next_state = S0;
		endcase
	end
endmodule
