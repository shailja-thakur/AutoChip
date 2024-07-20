module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

always @(posedge clk) begin
	// Sequential logic to update state and q
	if (a == 1'b1 && b == 1'b1) begin
		state <= ~state;
		q <= state;
	end
	else if (a == 1'b1 && b == 1'b0) begin
		q <= 1'b1;
	end
	else if (a == 1'b0 && b == 1'b1) begin
		q <= 1'b0;
	end
	else if (a == 1'b0 && b == 1'b0) begin
		q <= state;
	end
end

endmodule
