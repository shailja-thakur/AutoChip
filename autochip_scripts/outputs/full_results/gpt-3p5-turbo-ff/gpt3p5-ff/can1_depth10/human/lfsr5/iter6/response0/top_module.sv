module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] lfsr;
  wire lfsr_tap;

  assign lfsr_tap = lfsr[4] ^ lfsr[2];

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      lfsr <= 5'b10000;
      q <= 1'b1;
    end else begin
      lfsr <= {lfsr_tap, lfsr[4:1]};
      q <= lfsr;
    end
  end

endmodule
