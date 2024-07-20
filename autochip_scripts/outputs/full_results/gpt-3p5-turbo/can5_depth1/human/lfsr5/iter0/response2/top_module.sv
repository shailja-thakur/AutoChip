module top_module(
  input clk,
  input reset,
  output reg [4:0] q);
  
  reg [4:0] lfsr;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      lfsr <= 5'd1;
    end else begin
      lfsr[4:1] <= {lfsr[3] ^ lfsr[0], lfsr[4:2]};
      lfsr[0] <= lfsr[4];
    end
  end
  
  assign q = lfsr;
  
endmodule
