module top_module (
  input clk,
  input d,
  input ar,
  output q
); 

  reg q;
  
  always @ (posedge clk or ar)
  begin
    if (ar)
      q <= 0;
    else if (clk)
      q <= d;  
  end

endmodule
