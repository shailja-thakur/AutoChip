module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg state, state_next;

	always @(posedge clk or negedge aresetn)
		if (!aresetn)
			state <= S;
		else
			state <= state_next;

	always @(state, x)
		case({state, x})
			{S, 0}: state_next = S;
			{S, 1}: state_next = S1;
			{S1, 0}: state_next = S10;
			{S1, 1}: state_next = S1;
			{S10, 0}: state_next = S;
			{S10, 1}: state_next = S1;
			default: state_next = state;
		endcase

	always @(state)
		case(state)
			S: z = 0;
			S1: z = 0;
			S10: z = x;
			default: z = 0;
		endcase
endmodule
