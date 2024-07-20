module top_module(
  input x,
  input y,
  output reg z
);
  
  reg x_prev, y_prev;
  
  always @(x or y) begin
    x_prev <= x;
    y_prev <= y;
  end
  
  always @(x_prev or y_prev) begin
    if(x_prev & y_prev)
      z <= 1;
    else
      z <= 0;
  end
  
endmodule
