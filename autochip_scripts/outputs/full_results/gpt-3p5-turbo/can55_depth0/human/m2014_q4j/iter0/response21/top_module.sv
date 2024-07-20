module top_module (
   input [3:0] x,
   input [3:0] y,
   output [4:0] sum
);

   wire [3:0] carry;
   wire [3:0] sum_temp;

   // Define full adder module
   module full_adder (
      input a,
      input b,
      input cin,
      output cout,
      output sum
   );

      assign sum = a ^ b ^ cin;
      assign cout = (a & b) | (a & cin) | (b & cin);

   endmodule
