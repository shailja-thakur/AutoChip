module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_q;
  reg [31:0] lfsr;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      lfsr <= 32'h1;
      q <= 32'h1;
    end else begin
      next_q = {lfsr[30:0], lfsr[0] ^ lfsr[20] ^ lfsr[30] ^ lfsr[31]};
      lfsr <= next_q;
      q <= next_q;
    end
  end

endmodule
