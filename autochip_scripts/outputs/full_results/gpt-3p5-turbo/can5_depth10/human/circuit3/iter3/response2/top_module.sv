module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output reg q
);

  always @* begin
    case ({a, b, c, d})
      4'b0000, 4'b0001, 4'b0010, 4'b0011 : q = 1'b0;
      4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1011, 4'b1110, 4'b1111 : q = 1'b1;
      4'b1000, 4'b1100, 4'b1001, 4'b1010, 4'b1101 : q = 1'b0;
      default: q = 1'b1;
    endcase
  end

endmodule
