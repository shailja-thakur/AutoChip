module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] lfsr;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      lfsr <= 5'b10000;
      q <= 1'b1;
    end else begin
      lfsr <= {lfsr[4] ^ lfsr[3] ^ lfsr[0], lfsr[4:1]};
      q <= lfsr;
    end
  end

endmodule
