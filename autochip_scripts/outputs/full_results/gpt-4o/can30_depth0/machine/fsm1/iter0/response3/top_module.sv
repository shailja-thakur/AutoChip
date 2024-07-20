module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg state;
	reg next_state;
	
	parameter A = 1'b0;
	parameter B = 1'b1;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end
	
	always @(*) begin
		case (state)
			A: next_state = (in) ? A : B;
			B: next_state = (in) ? B : A;
			default: next_state = B;
		endcase
	end
	
	always @(*) begin
		out = (state == B) ? 1'b1 : 1'b0;
		end
	
endmodule
