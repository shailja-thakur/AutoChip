module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] lfsr;
  reg shift;

  always @(posedge clk or posedge reset) begin
    if (reset)
      lfsr <= 5'b1;
    else begin
      shift = lfsr[4] ^ lfsr[2];
      lfsr = {shift, lfsr[4:1]};
    end
  end

  assign q = lfsr;

endmodule
