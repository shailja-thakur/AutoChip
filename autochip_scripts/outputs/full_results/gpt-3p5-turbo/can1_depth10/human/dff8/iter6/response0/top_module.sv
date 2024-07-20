module dff (
  input clk,
  input d,
  output reg q
);

  always @(posedge clk) begin
    q <= d;
  end

endmodule
module top_module(
  input clk,
  input [7:0] d,
  output [7:0] q
);

  reg [7:0] q_reg;

  always @(posedge clk) begin
    q_reg <= d;
  end

  assign q = q_reg;

endmodule
