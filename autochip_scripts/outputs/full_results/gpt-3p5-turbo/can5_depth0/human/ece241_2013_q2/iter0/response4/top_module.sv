module top_module (
   input a,
   input b,
   input c,
   input d,
   output out_sop,
   output out_pos
);
 
  // Define the wire for the output
  wire out;
  
  // Logic for out_sop
  assign out_sop = (a && !b && !c && !d) || (!a && !b && !c && d) || (!a && !b && c && !d);
  
  // Logic for out_pos
  assign out_pos = (a || b || c || !d) && (a || b || !c || d) && (a || !b || c || d);
  
endmodule
