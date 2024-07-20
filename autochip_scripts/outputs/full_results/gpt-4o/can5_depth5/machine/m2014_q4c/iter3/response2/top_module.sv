module top_module (
	input clk,
	input d,
	input r,
	output reg q
);

always @(posedge clk or posedge r) begin
	if (r)
		q <= 1'b0; // Ensure q is reset to 0 correctly
	else
		q <= d; // Store the input value d
end

endmodule
