module top_module(
  input clk,
  input reset,
  output shift_ena);

  reg [3:0] counter;

  always @(posedge clk) begin
    if (reset)
      counter <= 4'b0;
    else if (counter < 4)
      counter <= counter + 1'b1;
    else
      counter <= 4'b0;
  end

  assign shift_ena = (reset || (counter < 4'b1000));

endmodule
