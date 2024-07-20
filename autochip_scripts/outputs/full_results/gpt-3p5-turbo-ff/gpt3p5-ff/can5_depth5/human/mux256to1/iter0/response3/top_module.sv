module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

// Create a 1-bit wide, 256-to-1 multiplexer. The 256 inputs are all packed into a single 256-bit input vector. sel=0 should select in[0], sel=1 selects bits in[1], sel=2 selects bits in[2], etc.
wire [255:0] mux_out;

reg [7:0] sel_reversed;

always @* begin
	for (int i = 0; i < 8; i = i + 1) begin
		sel_reversed[i] = sel[7 - i];
	end
end

assign mux_out = {in[255-sel_reversed], 1'b0};

assign out = mux_out[0];

endmodule
