module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

// Create a synchronous reset D flip flop
always_ff @(posedge clk, posedge r) begin
	if (r)
		q <= 0;
	else
		q <= d;
end

endmodule
