module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Signal to store intermediate values
	reg [98:0] both;
	reg [99:1] any;
	reg [99:0] different;

	// Logic for out_both
	always @* begin
		for (int i = 0; i < 99; i = i + 1) begin
			both[i] = (in[i] & in[i+1]);
		end
	end

	// Logic for out_any
	always @* begin
		for (int i = 1; i < 100; i = i + 1) begin
			any[i] = (in[i] | in[i-1]);
		end
	end

	// Logic for out_different
	always @* begin
		for (int i = 0; i < 100; i = i + 1) begin
			different[i] = (in[i] != in[(i+99)%100]);
		end
	end

	// Assigning outputs
	assign out_both = both;
	assign out_any = any;
	assign out_different = different;

endmodule
