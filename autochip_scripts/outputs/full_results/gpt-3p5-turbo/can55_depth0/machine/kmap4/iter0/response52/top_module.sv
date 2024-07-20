module top_module (
  input a, 
  input b,
  input c,
  input d,
  output reg out
);

  always @* begin
    case({a, b, c, d})
      4'b0000: out = 1'b0; // if a, b, c, and d are all 0, then output out is 0
      4'b1111: out = 1'b1; // if a, b, c, and d are all 1, then output out is 1
      default: out = 1'b0; // output is 0 for any other combination of inputs
    endcase
  end
    
endmodule
