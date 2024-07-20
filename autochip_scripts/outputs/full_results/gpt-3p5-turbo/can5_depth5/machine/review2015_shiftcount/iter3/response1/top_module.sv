module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

  always @(posedge clk) begin
    if (shift_ena == 1'b1)
      q <= data;
    else if (count_ena == 1'b1)
      q <= q - 1;
  end

endmodule
