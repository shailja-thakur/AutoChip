module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

   // Declare internal wire variables for intermediate calculations
   wire [99:0] and_intermediate;
   wire [99:0] or_intermediate;
   wire [99:0] xor_intermediate;
   
   // Perform logical AND operation on input vector
   assign and_intermediate = &in;

   // Perform logical OR operation on input vector
   assign or_intermediate = |in;

   // Perform logical XOR operation on input vector
   assign xor_intermediate = ^in;

   // Assign the output ports
   assign out_and = and_intermediate[99];
   assign out_or = or_intermediate[99];
   assign out_xor = xor_intermediate[99];
   
endmodule
