module top_module(
  input clk,
  input [7:0] in,
  output [7:0] pedge);

  reg [7:0] d_last;

  always @(posedge clk) begin
    d_last <= in;
    pedge <= in & ~d_last;
  end

endmodule
