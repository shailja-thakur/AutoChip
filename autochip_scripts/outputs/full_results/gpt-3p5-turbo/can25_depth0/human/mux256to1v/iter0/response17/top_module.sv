module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	
	// Create wire to hold selected 4-bit input
	wire [3:0] selected_bits;
	
	// Create 256-to-1 multiplexer
	always @(*) begin
		case(sel)
			0: selected_bits = in[3:0];
			1: selected_bits = in[7:4];
			2: selected_bits = in[11:8];
			// add more cases for the remaining selections
			default: selected_bits = 4'b0; // default selection to all zeros
		endcase
	end
	
	// Assign the output
	assign out = selected_bits;
	
endmodule
