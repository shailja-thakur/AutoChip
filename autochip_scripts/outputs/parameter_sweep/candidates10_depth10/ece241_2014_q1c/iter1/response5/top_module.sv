module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Declare internal signals
	reg signed [8:0] sum; // Sum of a and b (including carry bit)
	reg carry; // Carry out of the most significant bit
	
	// Assign outputs
	assign s = sum[7:0]; // Output the lower 8 bits of the sum
	assign overflow = carry ^ sum[8]; // Output overflow as the XOR of the carry and MSB
	
	// Perform the addition operation
	always @(*) begin // Use combinational logic
		sum = a + b; // Add a and b
		
		// Check for carry
		if (sum[8] == 1'b1) // MSB is 1
			carry = 1'b1; // Set carry to 1
		else
			carry = 1'b0; // Set carry to 0
	end
	
	initial begin
	  // Stimulus
	  a = 8'b00000001;
	  b = 8'b00000001;
	  #10;
	  
	  // Check the outputs
	  if (s != 8'b00000010) begin
	    $display("Error: Incorrect sum output");
	  end
	  if (overflow != 1'b0) begin
	    $display("Error: Incorrect overflow output");
	  end
	  
	  // Stimulus
	  a = 8'b10000000;
	  b = 8'b10000000;
	  #10;
	  
	  // Check the outputs
	  if (s != 8'b00000000) begin
	    $display("Error: Incorrect sum output");
	  end
	  if (overflow != 1'b1) begin
	    $display("Error: Incorrect overflow output");
	  end
	  
	  $finish;
	end
	
endmodule
