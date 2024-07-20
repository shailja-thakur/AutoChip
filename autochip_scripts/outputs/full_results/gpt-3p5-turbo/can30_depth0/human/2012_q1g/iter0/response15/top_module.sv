module top_module (
  input [4:1] x,
  output logic f
);

  always_comb begin
    case (x)
      4'b0000, 4'b0011, 4'b0111:
        f = 1;
      4'b1001, 4'b1010, 4'b1100:
        f = 0;
      default:
        f = x[1] & x[3] | x[1] & x[4] | x[2] & x[3] | x[3] & x[4];
    endcase
  end
 
endmodule
