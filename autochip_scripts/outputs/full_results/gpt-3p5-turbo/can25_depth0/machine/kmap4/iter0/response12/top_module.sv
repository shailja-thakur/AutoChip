module top_module (
  input a, 
  input b,
  input c,
  input d,
  output reg out
);

  always @* begin
    // Combine the four inputs into a 4-bit vector
    case ({a, b, c, d})
      // Define the output for each input combination
      4'b0000: out = 1'b0; // if a, b, c, and d are all 0, then out is 0
      4'b1111: out = 1'b1; // if a, b, c, and d are all 1, then out is 1
      4'b0101: out = 1'b0; // if a, b, c, and d are 0, 1, 0, and 1 respectively, then out is 0
      default: out = 1'b1; // for any other combination, out is 1
    endcase
  end

endmodule
