module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [2:0] state, next_state;

	// State encoding
	parameter S0 = 3'b000, // Initial state
	          S1 = 3'b001, // First 1 detected
	          S2 = 3'b010, // 11 detected
	          S3 = 3'b011, // 110 detected
	          S4 = 3'b100; // 1101 detected

	// State transition logic
	always @(*) begin
		case(state)
			S0: next_state = data ? S1 : S0;
			S1: next_state = data ? S2 : S0;
			S2: next_state = data ? S2 : S3;
			S3: next_state = data ? S1 : S4;
			S4: next_state = S4; // Remain in S4 once the sequence is detected
			default: next_state = S0;
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk) begin
		if (reset)
			start_shifting <= 0;
		else if (state == S4)
			start_shifting <= 1;
	end

endmodule
