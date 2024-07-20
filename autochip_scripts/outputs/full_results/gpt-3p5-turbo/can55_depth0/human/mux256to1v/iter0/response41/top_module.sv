module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Number of bits per select
	parameter N = 4;
	// Number of inputs per select
	parameter M = 256;

	// Signal to store the selected bits
	reg [3:0] selected_bits;

	always @(*) begin
		case (sel)
			0: selected_bits = in[3:0];
			1: selected_bits = in[7:4];
			2: selected_bits = in[11:8];
			// Add more cases for other select values if needed...
			default: selected_bits = 4'b0; // Default value when sel is out of range
		endcase
	end

	assign out = selected_bits;

endmodule
