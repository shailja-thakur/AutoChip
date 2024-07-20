module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a == 1) begin
		q <= 3'd4; // When 'a' is 1, set 'q' to 4
	end else if (a == 0 && q == 3'd6) begin
		q <= 3'd0; // When 'a' is 0 and 'q' is 6, set 'q' to 0
	end else if (a == 0) begin
		q <= q + 1; // When 'a' is 0 and 'q' is not 6, increment 'q' by 1
	end
end

endmodule
