module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	reg [1023:0] temp; // Create a temporary register to store the 1024-bit input vector
	
	always @(*) begin
		temp = in; // Assign the input vector to the temporary register
		out = temp[sel +: 4]; // Extract the 4-bit block from the temporary register based on the selection vector
	end
endmodule
