module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);
  reg next_Q;

  always @(posedge clk) begin
    if (E) begin
      if (L)
        next_Q <= R;
      else
        next_Q <= Q;
    end
    else begin
      if (L)
        next_Q <= 1'b0;
      else
        next_Q <= w;
    end
  end
  
  always @(posedge clk)
    Q <= next_Q;
  
endmodule
