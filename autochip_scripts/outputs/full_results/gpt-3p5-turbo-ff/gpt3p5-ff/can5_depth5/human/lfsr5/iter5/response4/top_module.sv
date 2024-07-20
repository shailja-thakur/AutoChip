module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] lfsr_reg;
  reg [4:0] next_lfsr;

  always @(posedge clk or posedge reset) begin
    if (reset)
      lfsr_reg <= 5'b1;
    else begin
      next_lfsr[4] = lfsr_reg[3] ^ lfsr_reg[2];
      next_lfsr[3:0] = lfsr_reg[4:1];
      lfsr_reg <= next_lfsr;
    end
  end

  assign q = lfsr_reg;

endmodule
