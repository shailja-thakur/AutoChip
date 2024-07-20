module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum reg [2:0] {
		S0,  // Initial state
		S1,  // 0 seen
		S2,  // 01 seen
		S3,  // 011 seen
		S4,  // 0111 seen
		S5,  // 01111 seen
		S6,  // 011111 seen
		S7   // 0111111 seen
	} state_t;

	state_t state, next_state;

	// Combinational logic for next state
	always @(*) begin
		case (state)
			S0: next_state = (in) ? S0 : S1;
			S1: next_state = (in) ? S2 : S1;
			S2: next_state = (in) ? S3 : S1;
			S3: next_state = (in) ? S4 : S1;
			S4: next_state = (in) ? S5 : S1;
			S5: next_state = (in) ? S6 : S1;
			S6: next_state = (in) ? S7 : S1;
			S7: next_state = (in) ? S7 : S1;  // Continuous 1s beyond 7 remains in error state
			default: next_state = S0;
		endcase
	end

	// Sequential logic for state transition
	always @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
		end

	// Output logic for disc, flag, and err
	always @(posedge clk) begin
		if (reset) begin
			disc <= 0;
			flag <= 0;
			err <= 0;
		end else begin
			disc <= 0;
			flag <= 0;
			err <= 0;

			case (next_state)
				S1: disc <= 0;
				S2: disc <= 0;
				S3: disc <= 0;
				S4: disc <= 0;
				S5: disc <= 0;
				S6: disc <= (in) ? 1 : 0; // disc if next input is 0
				S7: flag <= (in) ? 1 : 0; // flag if next input is 0
				default: err <= (state == S7 && in) ? 1 : 0; // error if continuous 1s
			endcase
		end
	end

endmodule
