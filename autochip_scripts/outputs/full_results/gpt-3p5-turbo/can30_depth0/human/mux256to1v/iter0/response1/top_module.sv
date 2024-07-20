module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	
	// Declare internal wire
	wire [3:0] selected_bits;
	
	// Create a 256-to-1 multiplexer
	mux256_1_mux4bit mux256_to_1(
		.in(in[(sel*4)+3 : sel*4]), // Select the correct bits based on sel
		.out(selected_bits)
	);
	
	// Assign output
	assign out = selected_bits;
	
	// Define 256-to-1 multiplexer module
	module mux256_1_mux4bit (
		input [255:0] in,
		output reg [3:0] out
	);
	
	// Perform multiplexing
	always @(*) begin
		case (sel)
			0: out = in[3:0];
			1: out = in[7:4];
			2: out = in[11:8];
			// Add cases for the remaining 253 selections
		endcase
	end
	
endmodule
