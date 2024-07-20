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
	if (a & ~b) begin
		state <= 1;
		q <= 1;
	end else if (~a & b) begin
		state <= 0;
		q <= 0;
	end
end

endmodule
