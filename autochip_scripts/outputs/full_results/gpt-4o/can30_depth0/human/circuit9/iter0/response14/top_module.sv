module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a) begin
			q <= 4;
		end else begin
			if (q == 4) begin
				q <= 5;
			end else if (q == 5) begin
				q <= 6;
			end else if (q == 6) begin
				q <= 0;
			end else begin
				q <= q + 1;
			end
		end
	end

endmodule
