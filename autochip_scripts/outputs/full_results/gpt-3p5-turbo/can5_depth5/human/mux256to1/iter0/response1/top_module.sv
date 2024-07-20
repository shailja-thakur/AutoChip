module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);
	// Create a wire to hold the selected 1-bit value from the input vector
	wire selected_bit;

	// Create a 256-to-1 multiplexer using a case statement
	always @* begin
		case (sel)
			0: selected_bit = in[0];
			1: selected_bit = in[1];
			2: selected_bit = in[2];
			// Add cases for the remaining inputs according to the specification
		endcase
	end

	assign out = selected_bit;

endmodule
