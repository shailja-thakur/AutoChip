module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q);

  reg [7:0] q_reg;
  
  always @(posedge clk or negedge reset) begin
    if (reset == 0) // active high synchronous reset
      q_reg <= 8'h34;
    else
      q_reg <= d;
  end
  
  always @(negedge clk) begin
    if (reset == 0) // active high synchronous reset
      q <= 8'h34;
    else
      q <= q_reg;
  end
endmodule
