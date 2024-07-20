module top_module ( input a, input b, input c, input d, output out );

  // Logic to implement the required functionality
  assign out = ((~c & ~b) | (~d & ~a) | (a & c & d) | (b & c & d));
  
endmodule
