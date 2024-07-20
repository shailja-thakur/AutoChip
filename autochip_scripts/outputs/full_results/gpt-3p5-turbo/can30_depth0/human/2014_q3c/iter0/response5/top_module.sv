module top_module (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);

reg [2:0] Y;
reg [2:0] next_Y;

always @(posedge clk) begin
  case ({y, x})
    3'b0000: next_Y = 3'b001;
    3'b0001: next_Y = 3'b001;
    3'b0010: next_Y = 3'b001;
    3'b0011: next_Y = 3'b010;
    3'b0100: next_Y = 3'b100;
    default: next_Y = 3'b000;
  endcase

  Y <= next_Y;
  Y0 <= next_Y[0];

  if (Y == 3'b011 || Y == 3'b100)
    z <= 1;
  else
    z <= 0;
end

endmodule
