module top_module(
	input a, 
	input b,
	input c,
	output out
);
   
   // Define the internal signals
   wire w1, w2, w3, w4;
   
   // Implement the logic for the internal signals
   assign w1 = ~a & b & c;
   assign w2 = a & b & c;
   assign w3 = a & ~b & c;
   assign w4 = a & b & ~c;
   
   // Implement the logic for the output
   assign out = w1 | w2 | w3 | w4;
   
endmodule
