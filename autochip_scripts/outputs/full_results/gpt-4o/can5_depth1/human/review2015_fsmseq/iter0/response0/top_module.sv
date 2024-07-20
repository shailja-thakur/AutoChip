module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	typedef enum reg [2:0] {S0, S1, S2, S3, S4} state_t;
	state_t state, next_state;

	always @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	always @(*) begin
		case (state)
			S0: next_state = data ? S1 : S0;
			S1: next_state = data ? S2 : S0;
			S2: next_state = data ? S2 : S3;
			S3: next_state = data ? S4 : S0;
			S4: next_state = S4; // Remains in this state once the sequence is detected
			default: next_state = S0;
		endcase
	end

	always @(posedge clk) begin
		if (reset)
			start_shifting <= 0;
		else if (state == S4)
			start_shifting <= 1;
	end

endmodule
