module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	typedef enum logic [2:0] {S, S1, S11, S110, Done} state_t;
	state_t state, next_state;

	// Combinational logic for next state
	always @(*) begin
		case (state)
			S: begin
				if (data)
					next_state = S1;
				else
					next_state = S;
			end
			S1: begin
				if (data)
					next_state = S11;
				else
					next_state = S;
			end
			S11: begin
				if (data)
					next_state = S11;
				else
					next_state = S110;
			end
			S110: begin
				if (data)
					next_state = Done;
				else
					next_state = S;
			end
			Done: begin
				next_state = Done;
			end
			default: next_state = S;
		endcase
	end

	// Sequential logic for state transition
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S;
		else
			state <= next_state;
		end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			start_shifting <= 1'b0;
		else if (state == Done)
			start_shifting <= 1'b1;
		else
			start_shifting <= 1'b0;
	end

endmodule
