module top_module (
    input [4:1] x,
    output logic f
);
  
  // Define internal wires
  wire w2, w3, w4;

  // Implement boolean expressions for each cell in the Karnaugh map
  assign w2 = ~(x[3] & x[4]);
  assign w3 = ~(x[3] & ~x[2]);
  assign w4 = ~(~x[3] & x[1]);

  // Implement boolean expression for the final output f
  assign f = ~(w2 & w3 & w4);

endmodule
