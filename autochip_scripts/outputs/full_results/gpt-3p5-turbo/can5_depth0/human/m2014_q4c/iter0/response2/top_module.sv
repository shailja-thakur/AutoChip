module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
	logic q_r; //internal signal for storing output
	
	always_ff @(posedge clk or posedge r)
	begin
		if (r)
			q_r <= 0;
		else
			q_r <= d;
	end
	
	assign q = q_r;
	
endmodule
