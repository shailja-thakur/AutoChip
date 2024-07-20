module top_module (
  input clk,
  input resetn,
  input in,
  output reg out
);

  reg [3:0] d_reg;

  always @(posedge clk or negedge resetn)
  begin
    if (~resetn)
      d_reg <= 4'b0;
    else
      d_reg <= {d_reg[2:0], in};
  end

  assign out = d_reg[3];

endmodule
