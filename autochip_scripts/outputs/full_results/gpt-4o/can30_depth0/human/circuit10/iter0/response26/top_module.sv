module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output state
);

reg ff_state;

assign state = ff_state;

always @(posedge clk) begin
	if (a & b) begin
		ff_state <= ~ff_state;
	end
	q <= ff_state;
end

endmodule
