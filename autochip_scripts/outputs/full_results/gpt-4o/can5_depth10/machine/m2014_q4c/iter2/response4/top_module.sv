module top_module (
	input clk,
	input d,
	input r,
	output reg q
);

always @(posedge clk or posedge r) begin
	if (r)
		q <= 1'b0;  // Explicitly setting reset value to binary 0 for clarity
	else
		q <= d;
end

endmodule
