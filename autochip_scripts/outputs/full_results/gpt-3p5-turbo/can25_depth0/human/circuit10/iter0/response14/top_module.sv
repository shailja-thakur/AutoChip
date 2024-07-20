module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg state;

always @(posedge clk) begin
	state <= state;
	if (state == 0) begin
		if (a == 0 && b == 0) begin
			q <= 0;
		end else if (a == 0 && b == 1) begin
			q <= 1;
		end else if (a == 1 && b == 0) begin
			q <= 1;
		end else begin
			q <= q;
		end
		state <= 0;
	end else begin
		q <= ~q;
		state <= 1;
	end
end
endmodule
