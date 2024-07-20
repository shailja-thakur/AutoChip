module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg state, next_state;
	
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
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = B;
		endcase
	end

	assign out = (state == B);

endmodule
