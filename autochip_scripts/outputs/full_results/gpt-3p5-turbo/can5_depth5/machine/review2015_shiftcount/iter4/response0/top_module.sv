module top_module(
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q);

  always @(posedge clk) begin
    if (shift_ena && count_ena) begin
      q <= q - 1;
      q[3:1] <= q[2:0];
      q[0] <= data;
    end else if (shift_ena) begin
      q[3:1] <= q[2:0];
      q[0] <= data;
    end else if (count_ena) begin
      q <= q - 1;
    end
  end

endmodule
