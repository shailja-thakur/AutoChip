module top_module (
  input [4:1] x,
  output logic f
);

always_comb begin
  case (x)
    4'b00xx: f = 0;
    4'b01x0: f = 0;
    4'b0001: f = 0;
    4'b0101: f = 1;
    4'b0110: f = 0;
    4'b0111: f = 1;
    4'b1001: f = 1;
    4'b1011: f = 1;
    4'b11xx: f = 1;
    default: f = 0;
  endcase
end

endmodule
