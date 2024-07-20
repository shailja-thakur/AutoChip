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

   wire p1y_in = p1a & p1b & p1c & p1d; // AND operation on inputs p1a, p1b, p1c, and p1d
   wire p2y_in = p2a & p2b & p2c & p2d; // AND operation on inputs p2a, p2b, p2c, and p2d
 
   assign p1y = ~p1y_in; // Invert the p1y_in output
   assign p2y = ~p2y_in; // Invert the p2y_in output

endmodule
