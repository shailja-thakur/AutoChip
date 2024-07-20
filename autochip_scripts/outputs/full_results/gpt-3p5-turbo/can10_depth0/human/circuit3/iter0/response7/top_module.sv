module top_module(
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
  
  // Implement the combinational circuit based on the provided simulation waveforms
  
  // Use gates and assign statements
  
  assign q = (~a & (~b & ~c & ~d)) | ((~a | ~b | ~c) & d);
  
endmodule
