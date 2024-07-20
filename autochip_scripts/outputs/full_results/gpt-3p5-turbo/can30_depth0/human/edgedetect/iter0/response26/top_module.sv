module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);

  reg [7:0] prev_in;

  always @(posedge clk) begin
    prev_in <= in;
    pedge <= (in & ~prev_in);
  end
endmodule
