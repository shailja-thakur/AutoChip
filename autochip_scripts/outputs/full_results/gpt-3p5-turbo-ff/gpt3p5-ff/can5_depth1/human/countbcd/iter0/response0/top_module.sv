module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);

  reg [15:0] q_next;
  reg [3:1] ena_next;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q_next <= 0;
      ena_next <= 0;
    end else begin
      q_next <= q + 1;
      ena_next <= {ena[2], ena[1], ena[0]};
    end
  end

  always @(posedge clk) begin
    q <= q_next;
    ena <= ena_next;
  end

endmodule
