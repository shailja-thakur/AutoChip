module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out_sop,
	output reg out_pos
);

	// Generate the SOP output
	always @* begin
		out_sop = (c & d) | ((~a & ~b) & c);
	end
	
	// Generate the POS outputs
	reg pos0, pos1;
	
	always @* begin
		pos0 = c & (~b | d) & (~a | b);
		pos1 = (~a | d) & c;
		
		if (pos0 === pos1)
			out_pos = pos0;
		else
			out_pos = 1'bx;
	end
	
	initial begin
		// Testbench code
		// Assign test values to inputs
		a = 0;
		b = 0;
		c = 0;
		d = 0;
		
		// Evaluate the module
		#10;
		
		// Check the outputs
		if (out_sop !== 0)
			$display("SOP output mismatch at time %t", $time);
		
		if (out_pos !== 0)
			$display("POS output mismatch at time %t", $time);
		
		// Assign new test values to inputs
		a = 1;
		b = 0;
		c = 1;
		d = 0;
		
		// Evaluate the module
		#10;
		
		// Check the outputs
		if (out_sop !== 1)
			$display("SOP output mismatch at time %t", $time);
		
		if (out_pos !== 1)
			$display("POS output mismatch at time %t", $time);
		
		// Add more test cases as needed
		
		// End simulation
		$finish;
	end
	
endmodule
