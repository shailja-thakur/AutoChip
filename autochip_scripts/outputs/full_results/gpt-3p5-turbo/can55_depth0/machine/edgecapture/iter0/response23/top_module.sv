module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);
	
	// Signal to store the previous value of in
	reg [31:0] d_last;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0; // Reset the output value
		else begin
			d_last <= in; // Store the previous value of in
			out <= out | (~in & d_last); // Modify the output value
		end
	end
endmodule
