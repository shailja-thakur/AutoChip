module top_module (
   input c,
   input d,
   output [3:0] mux_in
);

//Assigning the first bit of mux_in to the logical OR of c and d
assign mux_in[0] = c | d;

//Assigning the second bit of mux_in to 0
assign mux_in[1] = 0;

//Assigning the third bit of mux_in to the logical NOT of d
assign mux_in[2] = ~d;

//Assigning the fourth bit of mux_in to the logical AND of c and d
assign mux_in[3] = c & d;

endmodule
