module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);
	// Define intermediate signals
	reg [3:0] in_wrapped; // Wrap around input
	reg [2:0] out_both_temp; // Temporary signal for out_both
	
	// Wrap around input
	always @* begin
		in_wrapped[0] = in[3];
		in_wrapped[1] = in[0];
		in_wrapped[2] = in[1];
		in_wrapped[3] = in[2];
	end
	
	// Calculate out_both
	assign out_both_temp[0] = in_wrapped[0] & in_wrapped[1];
	assign out_both_temp[1] = in_wrapped[1] & in_wrapped[2];
	assign out_both_temp[2] = in_wrapped[2] & in_wrapped[3];
	
	// Assign out_both
	assign out_both = out_both_temp;
	
	// Calculate out_any
	assign out_any[1] = in[2] | in[1];
	assign out_any[2] = in[3] | in[2];
	assign out_any[3] = in[0] | in[3];
	
	// Calculate out_different
	assign out_different[0] = in[0] ^ in_wrapped[1];
	assign out_different[1] = in[1] ^ in_wrapped[2];
	assign out_different[2] = in[2] ^ in_wrapped[3];
	assign out_different[3] = in[3] ^ in[0];
endmodule
