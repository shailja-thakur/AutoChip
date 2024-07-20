module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg state;
	always @(posedge clk or posedge reset)
	begin
		if (reset) 
			state <= B;
		else if (state == B)
			state <= (in) ? B : A;
		else if (state == A)
			state <= (in) ? A : B;
	end

	always @(state)
	begin
		case (state)
			B: out = 1;
			A: out = 0;
		endcase
	end
endmodule
