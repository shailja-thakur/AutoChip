module top_module (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n );
    
  wire and1_out;
  wire and2_out;

  and gate1 (and1_out, a, b);
  and gate2 (and2_out, c, d);

  or gate3 (out, and1_out, and2_out);
  not gate4 (out_n, out);

endmodule
module and (
  output wire out,
  input wire in1,
  input wire in2 );
    
  assign out = in1 & in2;

endmodule
module or (
  output wire out,
  input wire in1,
  input wire in2 );
    
  assign out = in1 | in2;

endmodule
module not (
  output wire out,
  input wire in );
    
  assign out = ~in;

endmodule
