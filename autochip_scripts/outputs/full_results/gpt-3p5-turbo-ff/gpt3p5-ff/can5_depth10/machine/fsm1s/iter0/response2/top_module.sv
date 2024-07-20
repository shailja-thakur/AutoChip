module top_module (
	input clk,
	input in,
	input reset,
	output out
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state;
always @(posedge clk) begin
	if (reset) begin
		state <= B;
	end else begin
		case (state)
			A: state <= (in) ? A : B;
			B: state <= (in) ? B : A;
		endcase
	end
end

assign out = state;

endmodule
