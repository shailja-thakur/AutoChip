module top_module(
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q);

  always @(posedge clk) begin
    if(shift_ena) begin
      q <= data; // Shift the data input into the 4-bit register
    end else if(count_ena) begin
      q <= q - 1; // Decrement the 4-bit register
    end
  end

endmodule
