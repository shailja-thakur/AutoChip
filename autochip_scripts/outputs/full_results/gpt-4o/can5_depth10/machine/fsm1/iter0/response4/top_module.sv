module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	reg state, next_state;
	parameter A = 0, B = 1;

	// State transition logic
	always @(*) begin
		case (state)
			A: begin
				if (in) 
					next_state = A;
				else 
					next_state = B;
			end
			B: begin
				if (in) 
					next_state = B;
				else 
					next_state = A;
			end
			default: next_state = B;
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) 
			state <= B;
		else 
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		if (state == B) 
			out = 1;
		else 
			out = 0;
	end

endmodule
