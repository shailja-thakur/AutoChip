module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] lfsr_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      lfsr_reg <= 32'h1;
    end else begin
      lfsr_reg <= {lfsr_reg[30:0], lfsr_reg[31] ^ lfsr_reg[21] ^ lfsr_reg[1] ^ lfsr_reg[0]};
    end
  end

  assign q = lfsr_reg;

endmodule
