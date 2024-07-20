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
	if (reset)
		state <= B;
	else begin
		if (state == A) begin
			if (in)
				state <= A;
			else
				state <= B;
		end else begin
			if (in)
				state <= B;
			else
				state <= A;
		end
	end
end

assign out = state;

endmodule
