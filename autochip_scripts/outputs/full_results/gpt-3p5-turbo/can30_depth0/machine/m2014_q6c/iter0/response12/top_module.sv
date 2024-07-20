module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

  wire Y2_wire;
  wire Y4_wire;
  
  // Generate Y2 by taking the logical AND of the first bit of y and the logical NOT of w
  assign Y2_wire = y[1] & ~w;
  
  // Generate Y4 by taking the logical AND of the second, third, fifth and sixth bits of y and w
  assign Y4_wire = y[2] & y[3] & y[5] & y[6] & w;
  
  // Output the generated signals
  assign Y2 = Y2_wire;
  assign Y4 = Y4_wire;
  
endmodule
