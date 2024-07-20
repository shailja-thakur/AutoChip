module top_module (
  input [4:1] x,
  output logic f
);

always_comb begin
  case (x)
    4'b1100, 4'b1110, 4'b1101, 4'b1111:
      f = 1;
    4'b0100, 4'b0110, 4'b0111, 4'b0001:
      f = 0;
    default:
      f = x[1];
  endcase
end

endmodule
