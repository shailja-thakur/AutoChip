module top_module (
  input wire a,
  input wire b,
  output wire out_assign,
  output reg out_alwaysblock
);

  always @(a or b) begin
    out_assign = a & b;
  end

  always @(posedge clk) begin
    out_alwaysblock <= out_assign;
  end

endmodule