module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
  case (x)
    4'b00??: f = 0; // don't care
    4'b010?: f = 1;
    4'b11??: f = 1; // don't care
    4'b10??, 4'b11??: f = 0; // don't care
    default: f = 0; // for any other input, set f to 0
  endcase
end

endmodule
