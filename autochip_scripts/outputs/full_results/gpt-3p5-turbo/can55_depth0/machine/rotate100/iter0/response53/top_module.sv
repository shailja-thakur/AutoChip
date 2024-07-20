module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q);

  reg [99:0] shift_reg;
  
  always @(posedge clk) begin
    if (load)
      shift_reg <= data;
    else if (ena == 2'b01)
      shift_reg <= {shift_reg[98:0], 1'b0};
    else if (ena == 2'b10)
      shift_reg <= {1'b0, shift_reg[99:1]};
  end
  
  assign q = shift_reg;

endmodule
