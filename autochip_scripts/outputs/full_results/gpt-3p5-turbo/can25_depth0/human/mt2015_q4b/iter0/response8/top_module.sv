module top_module(
  input x,
  input y,
  output z);
  
  reg z_internal;
  
  always @* begin
    if(x && y)
      z_internal = 1;
    else if(x && !y)
      z_internal = 0;
    else if(!x && y)
      z_internal = 0;
    else if(!x && !y)
      z_internal = 1;
  end
  
  assign z = z_internal;
  
endmodule
