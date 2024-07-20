module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

// Create a 1-bit wide, 256-to-1 multiplexer. The 256 inputs are all packed into a single 256-bit input vector.
wire [255:0] mux_in;
assign mux_in = in;

// Define the output wire.
reg out;

// Implement the multiplexer logic using a case statement.
always @(*) begin
	case(sel)
		0: out = mux_in[0];
		1: out = mux_in[1];
		2: out = mux_in[2];
		// Add cases for the remaining inputs...
		default: out = 0; // Initialize out to some default value when sel is out of range
	endcase
end

endmodule
