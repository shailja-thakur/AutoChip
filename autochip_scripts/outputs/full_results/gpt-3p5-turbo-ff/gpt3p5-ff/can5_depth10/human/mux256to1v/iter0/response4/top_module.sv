module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Declare the internal wire for selecting the appropriate bits from the input vector
	wire [255:0] selected_bits;
	
	// Generate the selected_bits wire based on the sel input
	generate
		genvar i;
		for (i = 0; i <= 255; i = i + 1) begin : generate_bits
			assign selected_bits[i] = in[i*4 +: 4];
		end
	endgenerate
	
	// Create a 256-to-1 multiplexer to select the appropriate output based on the sel input
	always @* begin
		case (sel)
			0: out = selected_bits[0];
			1: out = selected_bits[1];
			2: out = selected_bits[2];
			3: out = selected_bits[3];
			4: out = selected_bits[4];
			5: out = selected_bits[5];
			6: out = selected_bits[6];
			7: out = selected_bits[7];
			default: out = 4'b0; // Default case when sel value is out of range
		endcase
	end
endmodule
