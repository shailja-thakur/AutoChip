module top_module (
	input [4:1] x,
	output logic f
);
  always_comb begin
    case (x)
      4'bxx00: f = 1; // x[3:1] = don't care, x[4] = 0
      4'bxx01: f = 0; // x[3:1] = don't care, x[4] = 1
      4'b11xx: f = 1; // x[1:2] = 1, x[3:4] = don't care
      4'b10xx: f = 0; // x[1:2] = 1, x[3:4] = don't care
      default: f = 1'b0; // default case, when no other case matches
    endcase
  end
endmodule
