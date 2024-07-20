module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a)
		q <= 3'd4;  // When "a" is high, the output "q" is set to 4
	else
		q <= q + 1; // When "a" is low, the output "q" increments by 1
end

endmodule
