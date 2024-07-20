module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

  wire q_temp1, q_temp2, q_temp3;

  assign q_temp1 = (~a & ~b & ~c & ~d);
  assign q_temp2 = (!d & c & ~b & ~a);
  assign q_temp3 = (c & b & ~a);
  assign q = (q_temp1 | q_temp2 | q_temp3);

endmodule
