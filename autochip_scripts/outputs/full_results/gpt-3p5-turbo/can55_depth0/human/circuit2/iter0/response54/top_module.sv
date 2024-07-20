module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);

  // Implementing the circuit based on the given waveform
  
  assign q = (!a && !b && !c && !d) || (!a && !b && !c && d) || (!a && !b && c && !d) || (!a && b && !c && d) || (!a && b && c && !d) || (a && !b && !c && !d) || (a && b && c && !d) || (a && b && c && d);

endmodule
