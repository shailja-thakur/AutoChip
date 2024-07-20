module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	reg [8:0] temp; // Create a temporary register to hold the sum result
	
	assign temp = a + b; // Add the two input numbers and store the result in temp
	
	always @(*) begin
		if (temp[8] == 1) // Check if the MSB of the sum is 1
			overflow = 1; // Set overflow signal to 1 if overflow has occurred
		else
			overflow = 0; // Set overflow signal to 0 if no overflow has occurred
		
		s = temp[7:0]; // Assign the least significant 8 bits of the sum to the output signal s
	end
	
endmodule
