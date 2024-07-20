module top_module(
  input clk,
  input d,
  output reg q);

  reg q_temp;
  reg q_dly;

  always @(posedge clk) begin
    q_temp <= d;
    q_dly <= q_temp;
  end

  always @(negedge clk) begin
    q <= q_dly;
  end

endmodule
