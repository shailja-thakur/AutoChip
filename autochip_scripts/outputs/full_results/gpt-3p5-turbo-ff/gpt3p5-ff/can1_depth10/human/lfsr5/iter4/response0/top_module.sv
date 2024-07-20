module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] lfsr;

  always @(posedge clk) begin
    if (reset) begin
      lfsr <= 5'b10000;
      q <= 1'b1;
    end else begin
      lfsr <= {lfsr[3] ^ lfsr[2], lfsr[4:1]};
      q <= lfsr;
    end
  end

endmodule
