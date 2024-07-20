module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a) begin
			q <= 3'b100; // When a is 1, set q to 4
		end else if (q == 6) begin
			q <= 3'b000; // When a is 0 and q is 6, set q to 0
		end else begin
			q <= q + 1; // When a is 0 and q is not 6, increase q by 1
		end
	end

endmodule
