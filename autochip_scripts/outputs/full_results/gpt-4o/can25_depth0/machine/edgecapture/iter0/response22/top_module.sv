module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] d_last; // Register to store the previous value of in

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out <= 0;       // Output is 0 when reset is asserted
			d_last <= 0;    // Reset the previous input value
		end else begin
			d_last <= in; // Store the current input value in d_last
			out <= out | (~in & d_last); // Modify the output as specified
		end
	end

endmodule
