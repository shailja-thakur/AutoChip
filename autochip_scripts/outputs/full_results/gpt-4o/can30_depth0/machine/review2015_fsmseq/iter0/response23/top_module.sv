module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting
);

	// State Definition
	typedef enum logic [2:0] {
		S = 3'd0,
		S1 = 3'd1,
		S11 = 3'd2,
		S110 = 3'd3,
		Done = 3'd4
	} state_t;

	state_t state, next_state;

	// State Transition Logic (Combinational)
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
			default: begin
				next_state = S;
			end
		endcase
	end

	// State Update Logic (Sequential)
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S;
		end
		else begin
			state <= next_state;
		end
		end

	// Output Logic
	always @(state) begin
		if (state == Done)
			start_shifting = 1'b1;
		else
			start_shifting = 1'b0;
	end

endmodule
