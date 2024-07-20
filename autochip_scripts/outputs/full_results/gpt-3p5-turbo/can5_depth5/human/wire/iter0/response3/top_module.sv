module top_module(
    input in,
    output out
);
   
   // Create a wire to connect the input and output
   wire wire_out;

   // Assign the input to the output
   assign out = wire_out;

   // Assign the wire to the input
   assign wire_out = in;

endmodule
