module top_module (
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] lfsr;
  reg [31:0] taps;

  always @(posedge clk) begin
    if (reset) begin
      lfsr <= 32'h1;
    end else begin
      taps[0] <= lfsr[0] ^ lfsr[1] ^ lfsr[21] ^ lfsr[31];
      taps[1] <= lfsr[1];
      taps[2] <= lfsr[2];
      // ...
      taps[21] <= lfsr[21];
      taps[31] <= lfsr[31];

      lfsr <= taps;
    end
  end

  assign q = lfsr;

endmodule
