module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	typedef enum reg [2:0] { S_IDLE, S_1, S_11, S_110, S_1101 } state_t;
	state_t state, next_state;

	// State transition logic (combinational)
	always @* begin
		next_state = state; // Default assignment
		case (state)
			S_IDLE: next_state = (data == 1'b1) ? S_1 : S_IDLE;
			S_1: next_state = (data == 1'b1) ? S_11 : S_IDLE;
			S_11: next_state = (data == 1'b0) ? S_110 : S_1;
			S_110: next_state = (data == 1'b1) ? S_1101 : S_IDLE;
			S_1101: next_state = S_1101; // Final state stays forever
		endcase
	end
	
	// State flip-flops with synchronous reset (sequential)
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S_IDLE;
		else
			state <= next_state;
	end
	
	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			start_shifting <= 1'b0;
		else if (state == S_1101)
			start_shifting <= 1'b1;
	end
	
endmodule
