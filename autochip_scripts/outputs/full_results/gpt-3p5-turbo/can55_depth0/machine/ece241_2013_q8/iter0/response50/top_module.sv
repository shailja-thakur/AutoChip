module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg state, state_next;

	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S;
		else
			state <= state_next;
	end

	always @(*) begin
		state_next = state;

		case (state)
			S: begin
				if (x == 0)
					state_next = S;
				else if (x == 1)
					state_next = S1;
			end
			S1: begin
				if (x == 0)
					state_next = S10;
				else if (x == 1)
					state_next = S1;
			end
			S10: begin
				if (x == 0)
					state_next = S;
				else if (x == 1)
					state_next = S1;
			end
		endcase
	end

	always @(*) begin
		case (state)
			S, S1: begin
				z = 0;
			end
			S10: begin
				z = x;
			end
		endcase
	end
endmodule
