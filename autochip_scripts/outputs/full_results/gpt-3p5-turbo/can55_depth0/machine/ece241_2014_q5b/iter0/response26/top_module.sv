module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= A;
	else begin
		case (state)
			A: state <= (x) ? B : A;
			B: state <= B;
		endcase
	end
end

assign z = (state == A && x) || (state == B && !x);

endmodule
