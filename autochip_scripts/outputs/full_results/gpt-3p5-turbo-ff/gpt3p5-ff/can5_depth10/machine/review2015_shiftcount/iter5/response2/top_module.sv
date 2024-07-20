module top_module(
input clk,
input shift_ena,
input count_ena,
input data,
output reg [3:0] q);

  reg [3:0] q_temp;

  always @(posedge clk)
  begin
    if(shift_ena)
      q_temp <= data;
    else if(count_ena)
      q_temp <= q_temp - 1;
  end

  always @(posedge clk)
  begin
    q <= q_temp;
  end

endmodule
