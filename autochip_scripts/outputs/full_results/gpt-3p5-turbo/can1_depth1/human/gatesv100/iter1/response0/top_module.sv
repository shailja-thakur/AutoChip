module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// signal to store the values for out_both
	reg [98:0] both;
	
	// signal to store the values for out_any
	reg [99:0] any;
	
	// signal to store the values for out_different
	reg [99:0] different;
	
	// calculate the values for out_both
	always @*
	begin
		for(int i=0; i<99; i=i+1)
		begin
			both[i] = (in[i] & in[i+1]);
		end
	end
	
	// calculate the values for out_any
	always @*
	begin
		for(int i=1; i<100; i=i+1)
		begin
			any[i] = (in[i] | in[i-1]);
		end
		
		// handle the case for in[0] separately as it has no right neighbor
		any[0] = in[0];
	end
	
	// calculate the values for out_different
	always @*
	begin
		for(int i=0; i<99; i=i+1)
		begin
			different[i] = (in[i] != in[i+1]);
		end
		
		// handle the case for in[99] separately as it wraps around to in[0]
		different[99] = (in[99] != in[0]);
	end
	
	// assign the signals to the outputs
	assign out_both = both;
	assign out_any = any[1:99];
	assign out_different = different;

endmodule
