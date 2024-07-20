module top_module (
  input a,
  input b,
  input c,
  input d,
  input e,
  output [24:0] out
);
  assign out = (~(25'b0)) ^ ({5{a,b,c,d,e}});
endmodule
