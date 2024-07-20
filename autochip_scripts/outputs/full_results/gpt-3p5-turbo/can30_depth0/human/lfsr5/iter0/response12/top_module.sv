module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] reg;
  
  always @(posedge clk) begin
    if (reset)
      reg <= 1;
    else
      reg <= {reg[3]^reg[4], reg[0], reg[1], reg[2], reg[3]};
  end
  
  assign q = reg;

endmodule
