module top_module (
  input [255:0] in,
  input [7:0] sel,
  output out
);

wire [0:255] mux_out;

assign mux_out[0] = sel[0] ? in[1] : in[0];
assign mux_out[1] = sel[0] ? in[3] : in[2];
assign mux_out[2] = sel[0] ? in[5] : in[4];
...
assign mux_out[255] = sel[7] ? in[511] : in[510];

assign out = mux_out[255];

endmodule
