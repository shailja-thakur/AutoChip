module top_module(
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q);
  
  always @(posedge clk) begin
    if (shift_ena) begin
      q[3] <= data;
      q[2] <= q[3];
      q[1] <= q[2];
      q[0] <= q[1];
    end
    
    if (count_ena) begin
      if (shift_ena && count_ena)
        q <= q - 1;
      else
        q <= q;
    end
  end
endmodule
