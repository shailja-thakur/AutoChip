module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);

	reg [255:0] mux_out; // Register for storing the output of the multiplexer

	always @(sel) begin
		case(sel)
			8'b00000000: mux_out <= in[0];
			8'b00000001: mux_out <= in[1];
			8'b00000010: mux_out <= in[2];
			8'b00000011: mux_out <= in[3];
			8'b00000100: mux_out <= in[4];
			8'b00000101: mux_out <= in[5];
			8'b00000110: mux_out <= in[6];
			8'b00000111: mux_out <= in[7];
			// Continue with all 256 cases
			default: mux_out <= in[0]; // Default case, select first input
		endcase
	end

	assign out = mux_out;

endmodule
