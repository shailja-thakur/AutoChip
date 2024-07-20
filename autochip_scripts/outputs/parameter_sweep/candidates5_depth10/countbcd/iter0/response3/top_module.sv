module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);

  reg [3:0] count [3:0];
  reg [2:0] enable;

  always@(posedge clk) begin
    if (reset == 1'b1) begin
      q <= 16'b0;
      count[3:0] <= 4'b0;
      enable <= 0;
    end else begin
      q <= {count[3],count[2],count[1],count[0]};
      count[3:0] <= count[3:0] + 4'b1;
      enable <= count[1:0] >= 2'b11;
    end
  end

  assign ena = enable;

endmodule
