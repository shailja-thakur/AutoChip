module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

   // Declare internal wires for intermediate signals
   wire w1;
   wire w2;
   wire w3;

   // Create the logic gates for the full adder
   xor gate1 (.a(a), .b(b), .out(w1));
   xor gate2 (.a(w1), .b(cin), .out(sum));
   
   and gate3 (.a(a), .b(b), .out(w2));
   and gate4 (.a(b), .b(cin), .out(w3));
   and gate5 (.a(a), .b(cin), .out(w4));

   or gate6 (.a(w2), .b(w3), .out(cout));
   or gate7 (.a(w2), .b(w4), .out(w5));
   or gate8 (.a(w3), .b(w4), .out(w6));
   or gate9 (.a(w5), .b(w6), .out(cout));

endmodule
