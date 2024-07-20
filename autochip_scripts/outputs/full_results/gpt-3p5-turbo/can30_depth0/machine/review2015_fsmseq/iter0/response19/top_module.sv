module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S;
		else
			state <= next_state;
	end

	always @(state or data) begin
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

			Done: next_state = Done;
		endcase
	end

	assign start_shifting = (state == Done);

endmodule
