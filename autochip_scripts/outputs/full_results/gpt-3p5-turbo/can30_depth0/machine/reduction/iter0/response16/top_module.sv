module top_module (
    input [7:0] in,
    output parity
);

   // Parity Checker
   assign parity = ^in;

endmodule
