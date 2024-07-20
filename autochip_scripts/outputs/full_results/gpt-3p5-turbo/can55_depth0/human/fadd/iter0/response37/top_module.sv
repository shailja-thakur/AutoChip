module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

   // Internal signals
   wire carry1, carry2;
   
   // Instantiate full adder
   full_adder adder1 (.a(a), .b(b), .cin(cin), .cout(carry1), .sum(sum1));
   full_adder adder2 (.a(sum1), .b(carry1), .cin(1'b0), .cout(cout), .sum(sum));
   
endmodule
module full_adder (
   input a, 
   input b, 
   input cin, 
   output sum, 
   output cout
);
   assign {cout, sum} = a + b + cin;
endmodule
