module top_module (
	input d,
	input ena,
	output logic q
);

	always @(*)
	begin
		if (ena) 
			q = d;
		else 
			q = q; // retain the value of q when ena is low
	end
	
endmodule
