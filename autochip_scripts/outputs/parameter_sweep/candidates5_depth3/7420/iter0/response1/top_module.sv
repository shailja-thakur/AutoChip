module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);
   
   // Internal wires
   wire p1A, p1B, p1C, p1D, p2A, p2B, p2C, p2D;
   
   // Connect the input wires to the inputs of the NAND gates
   assign p1A = p1a;
   assign p1B = p1b;
   assign p1C = p1c;
   assign p1D = p1d;
   assign p2A = p2a;
   assign p2B = p2b;
   assign p2C = p2c;
   assign p2D = p2d;
   
   // NAND gate outputs
   wire p1Y, p2Y;
   
   // Define the NAND gates
   nand2_gate0 u1 (
      .a(p1A),
      .b(p1B),
      .q(p1Y)
   );
   
   nand2_gate1 u2 (
      .a(p1C),
      .b(p1D),
      .q(p1Y)
   );
   
   nand2_gate2 u3 (
      .a(p2A),
      .b(p2B),
      .q(p2Y)
   );
   
   nand2_gate3 u4 (
      .a(p2C),
      .b(p2D),
      .q(p2Y)
   );
   
   // Connect the NAND gate outputs to the output wires
   assign p1y = p1Y;
   assign p2y = p2Y;

endmodule
module nand2_gate0 (
   input a,
   input b,
   output q
);
   // Implement the NAND gate functionality
   assign q = ~(a & b);

endmodule
module nand2_gate1 (
   input a,
   input b,
   output q
);
   // Implement the NAND gate functionality
   assign q = ~(a & b);

endmodule
module nand2_gate2 (
   input a,
   input b,
   output q
);
   // Implement the NAND gate functionality
   assign q = ~(a & b);

endmodule
module nand2_gate3 (
   input a,
   input b,
   output q
);
   // Implement the NAND gate functionality
   assign q = ~(a & b);

endmodule
