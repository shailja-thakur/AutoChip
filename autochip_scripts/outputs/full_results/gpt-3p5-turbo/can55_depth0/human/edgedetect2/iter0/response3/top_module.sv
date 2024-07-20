module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge);

  reg [7:0] in_reg = 8'b0;

  always @(posedge clk) begin
    in_reg <= in;
    anyedge <= (in_reg ^ in) & in;
  end

endmodule
