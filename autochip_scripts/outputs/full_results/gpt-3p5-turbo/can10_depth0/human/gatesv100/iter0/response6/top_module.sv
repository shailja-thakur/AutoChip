module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
	
	// Create temporary registers for calculations
	reg [99:0] inp;
	reg [98:0] both;
	reg [99:1] any;
	reg [99:0] different;
	
	// Assign input signal to the temporary register
	always @* begin
		inp = in;
	end
	
	// Calculate out_both
	// Iterate through each bit except the last one
	// (Since the last bit doesn't have a left neighbor)
	// If both the current bit and its left neighbor are '1', set the corresponding bit in out_both to '1'
	// Otherwise, set it to '0'
	always @* begin
		for (int i = 0; i < 99; i = i + 1) begin
			if (inp[i] && inp[i+1])
				both[i] = 1;
			else
				both[i] = 0;
		end
	end
	
	// Calculate out_any
	// Iterate through each bit except the first one
	// (Since the first bit doesn't have a right neighbor)
	// If either the current bit or its right neighbor is '1', set the corresponding bit in out_any to '1'
	// Otherwise, set it to '0'
	always @* begin
		for (int i = 1; i < 100; i = i + 1) begin
			if (inp[i] || inp[i-1])
				any[i] = 1;
			else
				any[i] = 0;
		end
	end
	
	// Calculate out_different
	// Iterate through each bit
	// Treat the vector as wrapping around, so in[99]'s neighbor to the left is in[0]
	// If the current bit is different from its left neighbor, set the corresponding bit in out_different to '1'
	// Otherwise, set it to '0'
	always @* begin
		for (int i = 0; i < 100; i = i + 1) begin
			if (inp[i] != inp[(i+1)%100])
				different[i] = 1;
			else
				different[i] = 0;
		end
	end
	
	// Assign the temporary registers to the output signals
	assign out_both = both;
	assign out_any = any;
	assign out_different = different;
	
endmodule
