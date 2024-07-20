module top_module (
  input [255:0] in,
  input [7:0] sel,
  output out
);
  
  wire [255:0] in_sel;

  assign in_sel = (sel < 256) ? in[sel] : 0;

  assign out = in_sel;
  
endmodule
