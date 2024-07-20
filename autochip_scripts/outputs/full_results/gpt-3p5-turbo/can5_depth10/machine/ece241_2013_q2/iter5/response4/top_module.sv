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

	// Initial values for the outputs
	initial begin
		out_sop = 0;
		out_pos = 0;
		#10; // Wait for inputs to settle
		
		// Test cases
		// Test 1
		{a, b, c, d} = 4'b0000; // Expected out_sop = 0, out_pos = 0
		#10;
		
		// Test 2
		{a, b, c, d} = 4'b0001; // Expected out_sop = 0, out_pos = 0
		#10;
		
		// Test 3
		{a, b, c, d} = 4'b0010; // Expected out_sop = 0, out_pos = 0
		#10;
		
		// Test 4
		{a, b, c, d} = 4'b0100; // Expected out_sop = 0, out_pos = 0
		#10;
		
		// Test 5
		{a, b, c, d} = 4'b0110; // Expected out_sop = 0, out_pos = 0
		#10;
		
		// Test 6
		{a, b, c, d} = 4'b1000; // Expected out_sop = 0, out_pos = 0
		#10;
		
		// Test 7
		{a, b, c, d} = 4'b1010; // Expected out_sop = 1, out_pos = 1
		#10;
		
		// Test 8
		{a, b, c, d} = 4'b1111; // Expected out_sop = 1, out_pos = 1
		#10;
		
		$finish;
	end
	
endmodule
