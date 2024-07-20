module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [255:0] inputs [0:7];

genvar i;
generate
  for (i = 0; i < 8; i = i + 1) begin
    assign inputs[i] = in[i*128 +: 128];
  end
endgenerate

mux_256to1 mux (
  .in(inputs[sel]),
  .out(out)
);

endmodule
