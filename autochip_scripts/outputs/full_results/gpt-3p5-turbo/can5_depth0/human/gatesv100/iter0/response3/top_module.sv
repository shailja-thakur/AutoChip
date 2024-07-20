module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Calculate out_both
	assign out_both[0] = in[0] & in[99];
	for (int i = 1; i < 99; i = i + 1) begin
		assign out_both[i] = in[i] & in[i-1];
	end

	// Calculate out_any
	for (int i = 0; i < 98; i = i + 1) begin
		assign out_any[i] = in[i] | in[i+1];
	end
	assign out_any[99] = in[99];

	// Calculate out_different
	assign out_different[0] = (in[0] != in[99]);
	for (int i = 1; i < 100; i = i + 1) begin
		assign out_different[i] = (in[i] != in[i-1]);
	end

endmodule
