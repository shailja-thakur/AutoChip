module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

parameter A = 0;
parameter B = 1;

reg state;

always @(posedge clk or negedge areset) begin
	if (areset == 0)
		state <= A;
	else begin
		case(state)
			A: begin
				if (x == 1)
					state <= B;
			end
			B: begin
				state <= B;
			end
		endcase
	end
end

always @(state or x) begin
	if ((state == A && x == 1) || (state == B && x == 0))
		z = 1;
	else
		z = 0;
end

endmodule
