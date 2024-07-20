module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  reg p1y_internal, p2y_internal;
  
  assign p1y = p1y_internal;
  assign p2y = p2y_internal;
  
  always @* begin
    p1y_internal = ~(p1[0] & p1[1] & p1[2] & p1[3]);
    p2y_internal = ~(p2[0] & p2[1] & p2[2] & p2[3]);
  end
  
endmodule
