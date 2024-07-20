module top_module (
	input clk,
	input d,
	input r,
	output reg q  // Change 'logic' to 'reg' for proper synthesis
);

always @(posedge clk or posedge r) begin
	if (r)
		q <= 1'b0;  // Explicitly use 1'b0 for correct reset behavior
	else
		q <= d;  // Store the value of the data input
end

endmodule
