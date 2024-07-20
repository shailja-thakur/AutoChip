module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] q_next;
  reg [4:0] q_reg;

  always @(posedge clk or posedge reset) begin
    if (reset)
      q_reg <= 5'h1;
    else
      q_reg <= q_next;
  end

  always @* begin
    q_next[4:1] = q_reg[3:0];
    q_next[0] = q_reg[4];
    q_next[2] = q_next[2] ^ q_reg[0];
  end

  assign q = q_reg;

endmodule
