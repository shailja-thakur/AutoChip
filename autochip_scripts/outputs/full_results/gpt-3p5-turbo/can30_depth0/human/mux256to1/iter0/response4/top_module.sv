module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

  wire [7:0] select_wire;
  assign select_wire = sel[7:0];

  wire [255:0] select_out;
  assign select_out = in[select_wire];

  assign out = select_out;

endmodule
