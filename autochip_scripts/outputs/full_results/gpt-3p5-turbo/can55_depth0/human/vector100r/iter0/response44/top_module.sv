module top_module (
	input [99:0] in,
	output reg [99:0] out
);

	// Use a for loop to iterate through each bit from 0 to 99
	// and assign the corresponding bit of `in` to the reverse index of `out`
	always @(in)
	begin
		for (integer i = 0; i < 100; i = i + 1)
		begin
			out[99 - i] = in[i];
		end
	end

endmodule
