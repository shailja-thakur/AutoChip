module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] lfsr;
  reg [4:0] next_lfsr;

  always @(posedge clk or posedge reset) begin
    if (reset)
      lfsr <= 5'b1;
    else
      lfsr <= next_lfsr;
  end

  always @(posedge clk) begin
    if (reset)
      next_lfsr <= 5'b1;
    else
      next_lfsr[4:0] <= {lfsr[3], lfsr[2:0] ^ lfsr[4], lfsr[3]};
  end

  assign q = lfsr;

endmodule
