module top_module (
	input clk,
	input d,
	input r,
	output reg q
);

always @(posedge clk or posedge r) begin
	if (r)
		q <= 1'b0;  // Ensure q is set to 0 explicitly when reset is active
	else
		q <= d;
end

endmodule
