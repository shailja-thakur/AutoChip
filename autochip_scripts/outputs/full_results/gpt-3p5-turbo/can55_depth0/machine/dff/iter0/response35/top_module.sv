module top_module (
  input clk,
  input d,
  output reg q
);

  reg [0:0] q;

  always @(posedge clk) begin
    q <= d;
  end

endmodule
