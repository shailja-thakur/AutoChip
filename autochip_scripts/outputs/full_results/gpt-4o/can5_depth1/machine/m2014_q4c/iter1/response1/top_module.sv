module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

always_ff @(posedge clk or posedge r) begin
	if (r)
		q <= 1'b0;  // Ensure q is properly set to 0 in binary form
	else
		q <= d;
end

endmodule
