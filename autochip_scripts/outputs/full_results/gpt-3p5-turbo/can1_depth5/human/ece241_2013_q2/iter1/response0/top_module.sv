module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

  // Define intermediate signals
  wire wire1, wire2, wire3;

  // Create AND gates to detect input conditions
  assign wire1 = (a & b & ~c & ~d) | (~a & b & c & ~d) | (~a & ~b & ~c & d);
  assign wire2 = (~a & b & ~c & ~d) | (a & ~b & c & ~d) | (~a & ~b & c & ~d) | (~a & ~b & ~c & d);
  assign wire3 = (a & b & ~c & ~d) | (a & ~b & c & ~d) | (a & ~b & ~c & d);

  // Create output equations using intermediate signals
  assign out_sop = wire1 | wire2 | wire3;
  assign out_pos = ~out_sop;

endmodule
