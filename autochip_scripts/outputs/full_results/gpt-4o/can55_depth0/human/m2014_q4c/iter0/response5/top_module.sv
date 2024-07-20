module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	always_ff @(posedge clk) begin
		if (r)
			q <= 1'b0; // Reset q to 0
		else
			q <= d; // Assign d to q on clock edge
	end
	
endmodule
