module top_module (
  input a, 
  input b,
  input c,
  input d,
  output reg out
);
  
  always @* begin
    case ({a, b, c, d})
      // add the missing cases here
    endcase
  end
  
endmodule
