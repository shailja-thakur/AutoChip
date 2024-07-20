module top_module(
input clk,
input shift_ena,
input count_ena,
input data,
output reg [3:0] q);

  // Initialize the register q with 0
  initial
    q = 4'b0000;

  always @(posedge clk)
  begin
    if(shift_ena)
      q <= data;
    else if(count_ena)
      q <= q - 1;
  end

endmodule
