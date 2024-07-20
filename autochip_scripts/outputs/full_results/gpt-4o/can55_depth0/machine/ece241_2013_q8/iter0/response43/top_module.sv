module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	typedef enum logic [1:0] {
		S    = 2'b00,
		S1   = 2'b01,
		S10  = 2'b10
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			S:   if (x) next_state = S1;  else next_state = S;
			S1:  if (x) next_state = S1;  else next_state = S10;
			S10: if (x) next_state = S1;  else next_state = S;
			default: next_state = S; // Default case to cover all possibilities
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			S:   z = 1'b0;
			S1:  z = 1'b0;
			S10: z = x;
			default: z = 1'b0; // Default case for safety
		endcase
	end

endmodule
