module top_module(
  input a,
  input b,
  output out
);

  not_inst not1(.in1(a|b), .out(out));

endmodule
