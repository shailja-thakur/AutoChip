module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
  
  reg or_1, or_2;
  
  always @(*) begin
    or_1 = a | b;
    or_2 = c | d;
    q = or_1 & or_2;
  end
  
endmodule
