module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

always @(posedge clk) begin
	if (a && b) begin
		state <= ~state;
		q <= state;
	end else if (a && !b) begin
		state <= 0;
		q <= state;
	end else if (!a && b) begin
		state <= 1;
		q <= state;
	end else begin
		q <= state;
	end
end

endmodule
