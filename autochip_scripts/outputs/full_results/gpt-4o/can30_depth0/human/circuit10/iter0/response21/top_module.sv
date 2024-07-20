module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

always @(posedge clk) begin
	if (a == 1 && b == 1) begin
		q <= !q;
		state <= !state;
	end else if (b == 1) begin
		q <= 1;
		state <= 1;
	end else begin
		q <= 0;
		state <= 0;
	end
end

endmodule
