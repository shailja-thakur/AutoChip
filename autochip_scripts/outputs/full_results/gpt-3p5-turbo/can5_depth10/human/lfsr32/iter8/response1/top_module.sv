module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] lfsr;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      lfsr <= 32'h1;
    end else begin
      lfsr <= {lfsr[30:0], lfsr[22] ^ lfsr[20] ^ lfsr[1] ^ lfsr[0]};
    end
  end
  
  assign q = lfsr;

endmodule
