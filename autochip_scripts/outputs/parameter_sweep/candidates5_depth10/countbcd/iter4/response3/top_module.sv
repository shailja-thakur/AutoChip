module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);

  reg [15:0] q_next;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 0;
    end else begin
      q <= q_next;
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q_next <= 0;
    end else begin
      q_next[3:0] <= q_next[3:0] + (ena[1] && (q_next[3:0] == 9));
      q_next[7:4] <= q_next[7:4] + (ena[2] && (q_next[7:4] == 9));
      q_next[11:8] <= q_next[11:8] + (ena[3] && (q_next[11:8] == 9));
      q_next[15:12] <= q_next[15:12] + (q_next[11:8] && (ena[3] == 1) && (q_next[15:12] == 9));
    end
  end
  
  assign ena = q[7:1];
  
endmodule
