module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);

  reg [3:1] ena_next;
  reg [15:0] q_next;

  always @(posedge clk) begin
    if(reset) begin
      q <= 0;
      ena <= 0;
    end else begin
      q <= q_next;
      ena <= ena_next;
    end
  end

  always @* begin
    q_next = q;
    ena_next = ena;

    if (ena[3] && q[11:8] == 9) begin
      q_next[11:8] = 0;
      ena_next[3] = 0;
      ena_next[2] = 1;
    end else if (ena[2] && q[7:4] == 9) begin
      q_next[7:4] = 0;
      ena_next[2] = 0;
      ena_next[1] = 1;
    end else if (ena[1] && q[3:0] == 9) begin
      q_next[3:0] = 0;
      ena_next[1] = 0;
    end else begin
      q_next = q + 1;
    end
  end
endmodule
