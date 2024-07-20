module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg state, next_state;
	
	// State encoding
	localparam A = 1'b0;
	localparam B = 1'b1;
	
	// State transition logic
	always @(*) begin
		case (state)
			A: if (in) next_state = A;
			   else next_state = B;
			B: if (in) next_state = B;
			   else next_state = A;
			default: next_state = B; // default to state B in case of undefined state
		endcase
	end
	
	// State register logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B; // reset state to B
		else
			state <= next_state;
	end
	
	// Output logic
	always @(state) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b0; // default to low output
		endcase
	end

endmodule
