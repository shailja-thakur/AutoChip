module top_module(
  input a, 
  input b,
  input c,
  output out
);

  wire d, e, f;
  
  assign d = ~a;
  assign e = b | c;
  assign f = d & e;
  assign out = ~f;
  
endmodule
