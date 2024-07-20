module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

always_ff @(posedge clk) begin
	if (r) // If reset is active high
		q <= 0; // Set output to 0
	else
		q <= d; // Set output to input
end

endmodule
