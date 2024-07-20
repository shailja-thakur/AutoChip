module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);
  
  reg [15:0] q_next;

  always @(posedge clk, posedge reset) begin
    if (reset) begin
      q_next <= 16'b0000;
    end else if (ena[1]) begin
      q_next <= q + 4'b0010;
    end else if (ena[2]) begin
      q_next <= q + 4'b0100;
    end else if (ena[3]) begin
      q_next <= q + 4'b1000;
    end else begin
      q_next <= q;
    end
  end

  always @(posedge clk) begin
    q <= q_next;
  end

endmodule
