module top_module(
  input clk,
  input reset,
  output reg [4:0] q);
  
  reg [4:0] lfsr;
  reg [4:0] next_lfsr;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      lfsr <= 5'b10000;
      q <= 1'b1;
    end else begin
      next_lfsr = lfsr << 1;
      next_lfsr[0] = lfsr[3] ^ lfsr[2];
      
      lfsr <= next_lfsr;
      q <= lfsr;
    end
  end

endmodule
