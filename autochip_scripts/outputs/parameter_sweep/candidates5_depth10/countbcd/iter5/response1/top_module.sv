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

  always @(posedge clk) begin
    if (reset) begin
      q_next <= 0;
    end else begin
      q_next[3:0] <= (q[3:0] == 9'b1001) ? 4'b0000 : q[3:0] + 1;
      q_next[7:4] <= (q[7:4] == 9'b1001) ? 4'b0000 : q[7:4] + (ena[1] ? 1 : 0);
      q_next[11:8] <= (q[11:8] == 9'b1001) ? 4'b0000 : q[11:8] + (ena[2] ? 1 : 0);
      q_next[15:12] <= (q[15:12] == 9'b1001) ? 4'b0000 : q[15:12] + (ena[3] ? 1 : 0);
    end
  end
  
  assign ena = q[7:1];
  
endmodule
