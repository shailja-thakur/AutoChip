module top_module(
  input wire clk,
  input wire d,
  output reg q);

  reg q_reg;
  
  always @(posedge clk or negedge clk) begin
    q_reg <= d;
    if (posedge clk)
      q <= q_reg;
  end
  
endmodule
