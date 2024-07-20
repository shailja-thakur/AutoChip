module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
	always @(*) begin
		// Calculate the output as XOR of all inputs
		out = a ^ b ^ c ^ d;
	end
endmodule
