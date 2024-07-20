module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// Define state encoding
	typedef enum logic [2:0] {
		S0, // Start state, behaves as if previous input was 0
		S1, // 0 seen
		S2, // 01 seen
		S3, // 011 seen
		S4, // 0111 seen
		S5, // 01111 seen
		S6, // 011111 seen
		S7, // 0111111 seen
		S8  // 01111111 seen (error)
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			S0: next_state = in ? S1 : S0;
			S1: next_state = in ? S2 : S0;
			S2: next_state = in ? S3 : S0;
			S3: next_state = in ? S4 : S0;
			S4: next_state = in ? S5 : S0;
			S5: next_state = in ? S6 : S0;
			S6: next_state = in ? S7 : S0;
			S7: next_state = in ? S8 : S0;
			S8: next_state = in ? S8 : S0;
			default: next_state = S0;
		endcase
	end

	// Output logic
	always @(*) begin
		disc = 0;
		flag = 0;
		err = 0;
		case (state)
			S6: if (~in) disc = 1; // Transition from S5 to S6 and see '0', discard bit
			S7: 
				if (~in) flag = 1; // Transition from S5 to S6 and see '0', then transition from S6 to S7 and see '1', flag boundary
				else disc = 1;
			S8: err = 1; // Seven or more 1s error
		endcase
	end

	// State register
	always @(posedge clk) begin
		if (reset) state <= S0;
		else state <= next_state;
	end

endmodule
