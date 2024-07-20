module top_module (
	input [4:1] x,
	output logic f
);

  always_comb begin
    f = 1'bx;
    case (x)
      4'h2, 4'h7, 4'h8, 4'h9: f = 0;
      4'h4, 4'h6, 4'hb, 4'hc, 4'he: f = 1;
    endcase
  end

endmodule
