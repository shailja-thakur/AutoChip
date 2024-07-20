module top_module (
    input a,
    input b,
    output sum,
    output cout
);
      
  // Declare internal signals
  wire c;
  
  // Addition operation
  assign sum = a + b; 
  assign cout = c;
  
endmodule
