module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
  case (x)
    4'b00xx: f = 0;
    4'b0100: f = 0;
    4'b01xx: f = 1;
    4'b0110: f = 0;
    4'b11xx: f = 1;
    4'b10xx: f = 1;
    4'b1100: f = 0;
    4'b1110: f = 0;
    default: f = 0; // Don't care
  endcase
end

endmodule
