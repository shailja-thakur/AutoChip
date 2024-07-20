module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	// D Flip Flop implementation
	always_ff @(posedge clk or posedge r) begin
		if (r)
			q <= 0;
		else if (d)
			q <= 1;
	end
    
endmodule
