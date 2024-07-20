module top_module (
  input [4:1] x,
  output logic f
);

always_comb begin
  case ({x[3], x[4]})
    2'b00: f = x[1] & ~x[2];
    2'b01: f = 1'b0;
    2'b10: f = x[1] ^ x[2];
    2'b11: f = x[2] & ~x[1];
    default: f = 1'b0;
  endcase
end

endmodule
