module top_module (
   input [3:0] in,
   output out_and,
   output out_or,
   output out_xor
);
   wire [3:0] in;
   wire out_and;
   wire out_or;
   wire out_xor;

   assign out_and = &in;
   assign out_or = |in;
   assign out_xor = ^in;
endmodule
