module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q);

  reg [7:0] q_reg;

  always @(posedge clk or posedge reset) begin
    if (reset)
      q_reg <= 8'b00110100;
    else
      q_reg <= d;
  end

  always @(negedge clk) begin
    q <= q_reg;
  end

endmodule
