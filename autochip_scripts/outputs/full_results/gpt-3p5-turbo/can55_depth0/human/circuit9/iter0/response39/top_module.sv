module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a == 1'b0) begin
		q <= 3'd0;
	end else if (q == 3'd6) begin
		q <= 3'd0;
	end else begin
		q <= q + 3'd1;
	end
end

endmodule
