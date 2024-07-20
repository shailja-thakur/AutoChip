module top_module (
  input [255:0] in,
  input [7:0] sel,
  output out
);

  reg [7:0] sel_reg;
  wire [255:0] sel_vector;
  
  assign sel_vector = {256{sel_reg}};
  
  always @ (posedge sel)
    sel_reg <= sel;
  
  assign out = in[sel_vector];
  
endmodule
