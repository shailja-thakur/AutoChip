module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
	always_ff @(posedge clk) begin
		if (r)       // Check for active high reset
			q <= 0;  // Reset q to 0
		else
			q <= d;  // Assign the input d to q on clock edge
	end
endmodule
