module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] lfsr_reg;
  reg [4:0] lfsr_next;

  always @(posedge clk or posedge reset) begin
    if (reset)
      lfsr_reg <= 5'b1;
    else
      lfsr_reg <= lfsr_next;
  end

  always @* begin
    lfsr_next[4] = lfsr_reg[3] ^ lfsr_reg[0];
    lfsr_next[3] = lfsr_reg[2];
    lfsr_next[2:0] = lfsr_reg[1:0];
  end

  assign q = lfsr_reg;

endmodule
