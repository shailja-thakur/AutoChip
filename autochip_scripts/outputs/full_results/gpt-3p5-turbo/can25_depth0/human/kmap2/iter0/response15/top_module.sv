module top_module (
  input a, 
  input b,
  input c,
  input d,
  output out
);
  
  reg out;

  always @(a or b or c or d)
  begin
    case({c, d})
      2'b00: out = a | b;
      2'b01: out = a & ~b;
      2'b10: out = a & ~c & ~d;
      2'b11: out = a | ~c | ~d;
    endcase
  end
  
endmodule
