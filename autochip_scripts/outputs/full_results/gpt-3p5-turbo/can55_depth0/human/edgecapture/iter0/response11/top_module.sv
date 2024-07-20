module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);

  reg [31:0] old_in;

  always @(posedge clk or posedge reset) begin
    if (reset)
      old_in <= 32'd0;
    else
      old_in <= in;
  end

  always @(posedge clk) begin
    out <= (old_in & ~in) | (out & ~reset);
  end

endmodule
