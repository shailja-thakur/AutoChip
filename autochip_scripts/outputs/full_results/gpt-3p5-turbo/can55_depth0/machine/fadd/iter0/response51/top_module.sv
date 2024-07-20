module top_module (
   input a,
   input b,
   input cin,
   output cout,
   output sum
);
   // Intermediate signal to store the sum of inputs
   wire [1:0] int_sum;
   
   // Calculate the sum of inputs a, b, and cin
   assign int_sum = a + b + cin;
   
   // Calculate the carry-out bit
   assign cout = (int_sum >= 2'b10) ? 1'b1 : 1'b0;
   
   // Calculate the sum output (modulo 2)
   assign sum = int_sum[0];
endmodule
