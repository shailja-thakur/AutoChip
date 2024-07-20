module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State encoding
	typedef enum logic [2:0] {
		S0 = 3'b000, // Initial state
		S1 = 3'b001, // After 1st '1'
		S2 = 3'b010, // After '11'
		S3 = 3'b011, // After '110'
		S4 = 3'b100  // Sequence found: '1101'
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			S0: next_state = data ? S1 : S0;
			S1: next_state = data ? S2 : S0;
			S2: next_state = data ? S2 : S3;
			S3: next_state = data ? S4 : S0;
			S4: next_state = S4; // Stay in S4 indefinitely once sequence is found
			default: next_state = S0;
		endcase
	end

	// State register logic
	always @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk) begin
		if (reset)
			start_shifting <= 1'b0;
		else if (state == S4)
			start_shifting <= 1'b1;
	end
	
endmodule
