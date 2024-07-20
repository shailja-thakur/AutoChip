module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);

  // Variables
  reg [3:0] shift_reg;

  // Combinational logic for load and ena inputs
  always @*
  begin
    if (load)
      shift_reg <= data;
    else if (ena)
      shift_reg <= {1'b0, shift_reg[3:1]};
  end

  // Synchronous reset
  always @(posedge clk or posedge areset)
  begin
    if (areset)
      shift_reg <= 4'b0;
    else
      shift_reg <= shift_reg;
  end

  // Assign shift register value to output q
  assign q = shift_reg;

endmodule
