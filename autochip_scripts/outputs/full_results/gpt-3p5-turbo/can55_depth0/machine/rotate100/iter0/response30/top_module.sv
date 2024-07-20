module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q);

  reg [99:0] output_reg;
  
  always @(posedge clk) begin
    if (load)
      output_reg <= data;
    else if (ena == 2'b01)
      output_reg <= {output_reg[98:0], 1'b0};
    else if (ena == 2'b10)
      output_reg <= {1'b0, output_reg[99:1]};
  end
  
  assign q = output_reg;
  
endmodule
