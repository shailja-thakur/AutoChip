module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [7:0] sel_extended;
reg out_reg;

// Extend the selection vector to match the width of the input vector
assign sel_extended = {8{sel}};

// Assign the output bit by selecting the corresponding bit from the input vector
assign out = in[sel_extended];

// Register the output bit to avoid glitches
always @(posedge clk) begin
  out_reg <= out;
end

endmodule
