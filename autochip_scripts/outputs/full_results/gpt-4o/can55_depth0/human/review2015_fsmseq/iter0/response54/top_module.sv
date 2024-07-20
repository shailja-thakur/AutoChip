module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State encoding
	typedef enum logic[2:0] {
		S0, // No bits matched
		S1, // "1" matched
		S2, // "11" matched
		S3, // "110" matched
		S4  // "1101" matched
	} state_t;

	state_t state, next_state;

	// State Transition Logic
	always @(*) begin
		case(state)
			S0: next_state = data ? S1 : S0;         // No bits matched
			S1: next_state = data ? S2 : S0;         // "1" matched
			S2: next_state = data ? S2 : S3;         // "11" matched
			S3: next_state = data ? S4 : S0;         // "110" matched
			S4: next_state = S4;                     // Sequence detected ("1101" matched)
			default: next_state = S0;
		endcase
	end

	// Sequential Logic
	always @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	// Output Logic
	always @(posedge clk) begin
		if(reset)
			start_shifting <= 0;
		else if(state == S4)
			start_shifting <= 1;
	end

endmodule
