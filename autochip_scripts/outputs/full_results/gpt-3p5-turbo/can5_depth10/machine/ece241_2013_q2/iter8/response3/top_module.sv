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
		// Initialize inputs
		a = 0;
		b = 0;
		c = 0;
		d = 0;
		
		// Wait for 1 time unit for inputs to settle
		#1;
		
		// Test case 1
		a = 0;
		b = 0;
		c = 0;
		d = 0;
		#1;
		if (out_sop !== 0 || out_pos !== 1'bx)
			$display("Test case 1 failed");
		
		// Test case 2
		a = 1;
		b = 0;
		c = 1;
		d = 0;
		#1;
		if (out_sop !== 0 || out_pos !== 1'bx)
			$display("Test case 2 failed");
		
		// Test case 3
		a = 0;
		b = 1;
		c = 1;
		d = 1;
		#1;
		if (out_sop !== 0 || out_pos !== 0)
			$display("Test case 3 failed");
		
		// Test case 4
		a = 1;
		b = 1;
		c = 1;
		d = 0;
		#1;
		if (out_sop !== 1 || out_pos !== 0)
			$display("Test case 4 failed");
			
		// Test case 5
		a = 0;
		b = 0;
		c = 1;
		d = 1;
		#1;
		if (out_sop !== 1 || out_pos !== 1)
			$display("Test case 5 failed");
		
		// Finish simulation
		$finish;
	end
	
endmodule
