module top_module (
  input [4:1] x,
  output logic f
);

  always_comb begin
    case (x)
      4'h1, 4'h6 : f = 1;
      4'h2, 4'h7, 4'h8, 4'h9, 4'hb, 4'hc : f = 0;
      4'h4, 4'he : f = 1;
      default : f = 1'bx;
    endcase
  end

endmodule
