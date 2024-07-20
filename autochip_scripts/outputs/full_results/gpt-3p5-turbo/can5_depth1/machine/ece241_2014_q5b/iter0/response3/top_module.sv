module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

parameter A = 0;
parameter B = 1;

reg state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= A;
	else begin
		case (state)
			A: if (x)
					state <= B;
			   else
			        state <= A;
			B: state <= B;
		endcase
	end
end

always @(state or x) begin
	if ((state == A && x) || (state == B && !x))
		z <= 1;
	else
		z <= 0;
end

endmodule
